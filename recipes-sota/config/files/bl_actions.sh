#!/usr/bin/bash

# ---
# Configuration
# ---

# DRY_RUN="0": normal execution mode (also if not set)
# DRY_RUN="1": show commands that would be executed but do not execute them (regarding
#              commands that change the state of the system)
# DRY_RUN="2": execute all commands except switching the partition in the CSD and reboot
DRY_RUN="${BL_DRY_RUN:-0}"

LOG_ENABLED="${BL_LOG_ENABLED:-0}"
LOG_VARS="${BL_LOG_VARS:-0}"

LOG_DIR="/var/lib/rollback-manager"
LOG_FILE="${LOG_DIR}/bootloader-update.log"

shopt -s expand_aliases
set -o pipefail

# ---
# Error handling support
# ---

# _die: Exit script even from subshells while not evaluating the "die" handler.
# die:  Exit script even from subshells while evaluating "die" handler.
# before_dying: Define expression to evaluate when before dying.

_die_handler=''
_exit_handler() {
    local ec=$?
    if [ "$ec" -eq 113 ]; then
        exit "$ec"
    elif [ "$ec" -ge 64 -a "$ec" -le 112 ]; then
	if [ "$$" -eq "$BASHPID" -a -n "$_die_handler" ]; then
	    # This is the top-level shell (run it and use its exit code).
	    eval "$_die_handler"
	    exit "$?"
	fi
	# Any exit code in the "user-defined" range propagates to the parent shell.
        exit "$ec"
    fi
}
set -E; trap '_exit_handler' ERR

_die() { exit 113; }
die() {
    log "FATAL: $@"
    if [ "$$" -eq "$BASHPID" -a -n "$_die_handler" ]; then
        # This is the top-level shell (run it and use its exit code).
	eval "$_die_handler"
	exit "$?"
    fi
    exit 112;
}
before_dying() { _die_handler="$1"; }
# ---

req_program() {
    if [ ! -x "$1" ]; then
        echo "FATAL: Program not found $1." >&2; _die;
    fi
    return 0
}

# External programs:
req_program "/usr/bin/cat"         && alias CAT="$_"
req_program "/usr/bin/date"        && alias DATE="$_"
req_program "/usr/bin/dd"          && alias DD="$_"
req_program "/usr/bin/fw_printenv" && alias FW_PRINTENV="$_"
req_program "/usr/bin/fw_setenv"   && alias FW_SETENV="$_"
req_program "/usr/bin/jq"          && alias JQ="$_"
req_program "/usr/bin/lsblk"       && alias LSBLK="$_"
req_program "/usr/bin/mkdir"       && alias MKDIR="$_"
req_program "/usr/bin/mmc"         && alias MMC="$_"
req_program "/usr/bin/sed"         && alias SED="$_"
req_program "/usr/bin/sha256sum"   && alias SHA256SUM="$_"
req_program "/usr/sbin/shutdown"   && alias SHUTDOWN="$_"
req_program "/usr/bin/stat"        && alias STAT="$_"
req_program "/usr/bin/touch"       && alias TOUCH="$_"
req_program "/usr/bin/tr"          && alias TR="$_"

# ---
# Basic logging infrastructure initialization.
# ---
prep_log_or_abort() {
    if [ "$LOG_ENABLED" = "1" ]; then
        if ! MKDIR -p "${LOG_DIR}"; then
            echo "Cannot create log directory" >&2; _die
        fi
        if ! TOUCH "${LOG_FILE}"; then
            echo "Cannot access log directory" >&2; _die
        fi
    fi
    return 0
}

log() {
    if [ "$LOG_ENABLED" = "1" ]; then
        echo "$(DATE '+%Y/%m/%d-%H:%M%S') $@" >>$LOG_FILE
    fi
}

log_action() {
    if [ "$LOG_ENABLED" = "1" ]; then
       (echo ""
        echo "---"
        echo "Date: $(DATE)"
        echo "Event: $1"
        shift
        echo "---"
        [ $# -ne 0 ] && echo "Extra parameters:"
        for parm in "$@"; do
            echo "- $parm"
        done
        if [ "$LOG_VARS" = "1" ]; then
            echo "Environment variables:"
            env
        fi) >>$LOG_FILE
    fi
}

# ---
# Finish logging infrastructure initialization.
# ---

maybe_run() {
    if [ "$DRY_RUN" = "1" ]; then
        log "WOULD RUN:" "$@"
        return 0
    else
        log "RUN:" "$@"
    fi
    eval "$@"
}

# output: Device name (without the /dev/)
get_emmc_dev() {
    local otaroot="/dev/disk/by-label/otaroot"
    if [ ! -e "$otaroot" ]; then
        die "Cannot find OTA root partition!"
    fi
    local devname="$(LSBLK -ndo pkname $otaroot)"
    if [ ! -b "/dev/$devname" ]; then
        die "Cannot determine eMMC device for bootloader"
    fi
    echo "$devname"
    return 0
}

# $1: eMMC device name (without /dev/)
# output: Current partition (integer as string: 1, 2)
get_emmc_active_partnum() {
    local devname="/dev/$1"
    local actpart=$(MMC extcsd read "$devname" | SED -Ene 's/^\s*boot partition\s*([0-9]+)\s*enabled.*$/\1/ip')
    if [ -z "$actpart" ]; then
        die "Cannot determine active partition on device $devname"
    fi
    echo "$actpart"
    return 0
}

# $1: eMMC device name (without /dev/)
# $2: Partition to activate (integer as string: 1, 2; 0 to disable)
switch_emmc_active_partnum() {
    local devname="/dev/$1"
    local partnum="$2"
    maybe_run MMC bootpart enable "$partnum" 1 "$devname"
    return
}

# $1: current partition
# output: Partition to switch to (integer as string)
get_emmc_other_partnum() {
    local actpart="$1"
    if [ "$actpart" = "1" ]; then
        echo "2"
    elif [ "$actpart" = "2" ]; then
        echo "1"
    else
        die "Cannot determine partition to switch to (current=$actpart)"
    fi
    return 0
}

get_prev_csdpart() {
    local prev_csdpart=$(FW_PRINTENV bl_prev_csdpart | SED -Ee 's/\s*bl_prev_csdpart=(.*)$/\1/')
    [ "$prev_csdpart" = "1" -o "$prev_csdpart" = "2" ] || die "Cannot determine previous partition from CSD"
    echo "$prev_csdpart"
    return 0
}

# $1: eMMC device name
# $2: eMMC boot partition number
get_bootpart() {
    local partnum="$2"
    local partidx=""
    if [ "$partnum" = "1" ]; then
        partidx="0"
    elif [ "$partnum" = "2" ]; then
        partidx="1"
    else
        die "Bad partition number passed to get_bootpart ($partnum)"
    fi
    echo "${1}boot${partidx}"
    return 0
}

# output: version or empty string if not available (no failure case)
get_bl_cur_version() {
    local src="/proc/device-tree/chosen/u-boot,version"
    local ver=$(CAT "$src" 2>/dev/null | TR -d '\0')
    echo "$ver"
    return 0
}

get_bl_new_version() {
    # Primary source of information: field 'bootloader.dtVersion'
    local dt_version=$(echo "$SECONDARY_CUSTOM_METADATA" | JQ -r '.bootloader.dtVersion' 2>/dev/null)
    if [ $? -eq 0 -a "$dt_version" != "null" ]; then
        echo "$dt_version"
        return 0
    fi
    # Secondary source of information: field 'version'
    local pkg_version=$(echo "$SECONDARY_CUSTOM_METADATA" | JQ -r '.version' 2>/dev/null)
    if [ $? -eq 0 -a "$pkg_version" != "null" ]; then
        echo "$pkg_version"
        return 0
    fi
    # Something wrong with the metadata.
    die "Cannot determine new bootloader version"
}

get_dd_options() {
    # Primary source of information: field 'bootloader.ddOptions'
    local dd_deflt="$1"
    local dd_opts0=$(echo "$SECONDARY_CUSTOM_METADATA" | JQ -r '.bootloader.ddOptions' 2>/dev/null)
    if [ $? -eq 0 -a "$dd_opts0" != "null" ]; then
        if [ "${dd_opts0:0:1}" = "!" ]; then
            # If string starts with an exclamation mark use it as is (ignore defaults).
            echo "${dd_opts0:1}"
            return 0
        else
            echo "${dd_opts0} ${dd_deflt}"
            return 0
        fi
    fi
    # Something wrong with the metadata.
    die "Cannot determine dd options for writing"
}

conv_dd_options() {
    # TODO: Review: currently we only take 'seek' an convert it into 'skip'.
    echo "$1" | SED -Ee 's/.*\bseek=([0-9]+).*/skip=\1/'
}

get_file_size() {
    local fname="$1"
    [ -r "$fname" ] || die "Cannot read $fname"
    local fsize=$(STAT -c "%s" $fname)
    [ -n "$fsize" ] || die "Cannot determine $fname's size"
    echo "$fsize"
    return 0
}

get_file_sha256() {
    local fname="$1"
    [ -r "$fname" ] || die "Cannot read $fname"
    local sha256=$(SHA256SUM "$fname" | SED -Ene 's/^\s*([0-9a-f]{64})\s*.*$/\1/p')
    [ -n "$sha256" ] || die "Cannot determine $fname's sha256"
    echo "$sha256"
    return 0
}

check_target_sha256() {
    local real_sha256=$(get_file_sha256 "$SECONDARY_FIRMWARE_PATH")
    local exp_sha256="$SECONDARY_FIRMWARE_SHA256"
    if [ "$real_sha256" = "$exp_sha256" ]; then
        log "Firmware file passed SHA-256 check"
        return 0
    fi
    die "SHA-256 mismatch for $SECONDARY_FIRMWARE_PATH (actual: ${real_sha256:0:12}..., exp.: ${exp_sha256:0:12}...)"
}

clean_uboot_vars() {
    log "Clearing u-boot variables"
    # Note that we're setting bl_prev_csdpart and bl_updt_status to '-' just because fw_setenv does
    # not seem to work with an empty string but right below we are also deleting these variables.
    maybe_run FW_SETENV \
              bl_prev_csdpart "-" \
              bl_updt_status "-" \
              bootcount "0" \
              upgrade_available "0"
    # Delete variables used only during the bootloader update (not strictly needed).
    maybe_run FW_SETENV bl_prev_csdpart
    maybe_run FW_SETENV bl_updt_status
}

on_install_failed() {
    if [ "$LOG_ENABLED" = "1" ]; then
        echo '{"status": "failed", "message": "action failed; check log at '$LOG_FILE'"}'
    else
        echo '{"status": "failed", "message": "action failed; enable log to see more"}'
    fi
    exit 0
}

check_install_vars() {
    [ -n "$SECONDARY_CUSTOM_METADATA" ] || die "SECONDARY_CUSTOM_METADATA is not set"
    [ -n "$SECONDARY_FIRMWARE_PATH" ]   || die "SECONDARY_FIRMWARE_PATH is not set"
    [ -n "$SECONDARY_FIRMWARE_SHA256" ] || die "SECONDARY_FIRMWARE_SHA256 is not set"
}

do_install() {
    # Note: if die is called from this point on the die handler will be called.
    before_dying 'on_install_failed'

    check_install_vars
    local emmc_dev=$(get_emmc_dev)
    local active_partnum=$(get_emmc_active_partnum "$emmc_dev")
    local other_partnum=$(get_emmc_other_partnum "$active_partnum")
    local active_bootpart=$(get_bootpart "$emmc_dev" "$active_partnum")
    local other_bootpart=$(get_bootpart "$emmc_dev" "$other_partnum")
    local cur_version=$(get_bl_cur_version)
    local new_version=$(get_bl_new_version)
    local dd_options_wr=$(get_dd_options "conv=fdatasync")
    # TODO: Consider a new field in metadata to specify how to do the reading.
    local dd_options_rd=$(conv_dd_options "$(get_dd_options)")

    log "Starting installation of bootloader"
    log "eMMC device: ${emmc_dev}"
    log "Active boot partition: ${active_bootpart}"
    log "Inactive boot partition: ${other_bootpart}"
    log "Old BL version: ${cur_version}"
    log "New BL version: ${new_version}"
    log "Options for 'dd' (writing): ${dd_options_wr}"
    log "Options for 'dd' (reading): ${dd_options_rd}"

    # 1: Basic input checks.
    if [ "$new_version" = "$cur_version" ]; then
        log "Updating to the same version: rollback will not be detected!"
    fi

    # 2: Check that binary about to be flashed has expected SHA-256 (safeguard).
    check_target_sha256

    # ---
    # 3: Lock partition, store, unlock partition. WARNING: Do not call "die" in this stretch.
    # ---

    # 3.1: Unlock destination partition.
    # TODO: Add trap here to always re-lock the partition on every case.
    echo 0 >"/sys/class/block/${other_bootpart}/force_ro"

    # 3.2: Copy file into destination partition.
    # NOTE: Currently we use the default block size so that dd_options can be taken from image.json;
    #       writing speed does not seem to change much with the block size anyway.
    maybe_run DD $dd_options_wr \
              if="$SECONDARY_FIRMWARE_PATH" \
              of="/dev/${other_bootpart}" 2>/dev/null
    local dd_res1="$?"

    # 3.3: Lock destination partition.
    echo 1 >"/sys/class/block/${other_bootpart}/force_ro"
    # ---

    # Avoid calling 'die' inside protected step.
    [ "$dd_res1" -eq 0 ] || die "Could not write to boot partition"

    # 4: Verify data from partition.
    local fwsize=$(get_file_size "$SECONDARY_FIRMWARE_PATH")
    local part_sha256_=$(DD \
                         $dd_options_rd \
                         if="/dev/${other_bootpart}" \
                         iflag=count_bytes \
                         count="$fwsize" 2>/dev/null | SHA256SUM)
    local part_sha256=$(echo "${part_sha256_}" | SED -Ene 's/^\s*([0-9a-f]{64})\s*.*$/\1/p')
    local dd_res2="$?"
    [ "$dd_res2" -eq 0 ] || die "Could not verify data in boot partition"

    if [ "$DRY_RUN" = "1" ]; then
        log "Ignoring actual partition digest in dry-run mode"
    elif [ "$part_sha256" = "$SECONDARY_FIRMWARE_SHA256" ]; then
        log "Partition data passed SHA-256 check"
    else
        die "SHA-256 mismatch for data in partition (actual: ${part_sha256:0:12}..., exp.: ${SECONDARY_FIRMWARE_SHA256:0:12}...)"
    fi

    # 5: Save u-boot environment variables.
    maybe_run FW_SETENV \
              bl_prev_csdpart "$active_partnum" \
              bl_updt_status "attempt" \
              bootcount "0" \
              upgrade_available "1"
    local setenv_res="$?"
    [ "$setenv_res" -eq 0 ] || die "Could not set u-boot environment"

    # 6: Switch active boot partition.
    if [ "$DRY_RUN" = "2" ]; then
        log "Not switching partition in dry-run mode"
    else
        if ! switch_emmc_active_partnum "$emmc_dev" "$other_partnum"; then
            clean_uboot_vars
            die "Could not switch active partition"
        fi
    fi

    # ---
    # WARNING: From this point on we must avoid calling "die" otherwise we would need to rollback to
    # the previous partition before returning to aktualizr.
    # ---

    # 7: Schedule reboot (precision is minutes); on return aktualizr will update its database to
    #    indicate an update is pending.
    if [ "$DRY_RUN" = "2" ]; then
        log "Not rebooting in dry-run mode"
    else
        maybe_run SHUTDOWN -r +1 2>/dev/null
        local shdwn_res="$?"
        # Do not die here since almost all work has been done.
        [ "$shdwn_res" -eq 0 ] || log "Could not schedule reboot"
    fi

    echo '{"status": "need-completion", "message": "rebooting soon"}'
    return 0
}

do_complete_install() {
    if [ -e /run/systemd/shutdown/scheduled ]; then
	# This could happen if the polling cycle is <1 minute.
	log "Delaying installation completion due to pending reboot"
        echo '{"status": "need-completion", "message": "delaying completion due to pending reboot"}'
	return 0
    fi

    # Note: if die is called from this point on the die handler will be called.; any failure here
    # will send a status of 'failed' to aktualizr (see 'on_install_failed()')
    before_dying 'on_install_failed'

    check_install_vars
    local emmc_dev=$(get_emmc_dev)
    local cur_version=$(get_bl_cur_version)
    local new_version=$(get_bl_new_version)

    log "Finishing installation of bootloader"
    log "eMMC device: ${emmc_dev}"
    log "Old BL version: ${cur_version}"
    log "New BL version: ${new_version}"

    if [ "$cur_version" = "$new_version" ]; then
        log "Successfully updated bootloader to version ${new_version}"
        clean_uboot_vars
        echo '{"status": "ok", "message": "bootloader update succeeded"}'
        return 0
    fi

    # ---
    # Error handling
    # ---
    local prev_partnum=$(get_prev_csdpart)
    log "Failed to update bootloader to version ${new_version}; performing rollback"

    # Switch to the previous boot partition; this should handle the case of a hardware rollback
    # where the system runs the previous bootloader even though the active partition is still
    # pointing to the bad/new bootloader version.
    if [ "$DRY_RUN" = "2" ]; then
        log "Not switching partition in dry-run mode"
    else
        switch_emmc_active_partnum "$emmc_dev" "$prev_partnum"
    fi

    clean_uboot_vars
    echo '{"status": "failed", "message": "bootloader update failed"}'
    return 0
}

# ---
# Main program
# ---

prep_log_or_abort

log_action "$@"

case "$1" in
    get-firmware-info)
        # Perform normal processing for this action.
        exit 64
        ;;
    install)
        do_install
        exit 0
        ;;
    complete-install)
        do_complete_install
        exit 0
        ;;
    *)
        # Perform normal processing for this action.
        log "Unknown action: $1"
        exit 64
        ;;
esac
