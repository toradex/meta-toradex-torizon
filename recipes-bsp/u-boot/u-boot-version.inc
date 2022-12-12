# In this module the u-boot-version.json file is created and deployed; that
# file will be used later during the generation of the TorizonCore image (see
# image_type_torizon.bbclass) to provide information about the bootloader
# binary to be made available through the Platform Services.

generate_version_file () {
    local outdir=${1:?Missing output directory argument}
    local outfile=${2:?Missing output file argument}
    local UBOOTVERSION="$(oe_runmake -C ${S} O=${outdir} -s ubootversion | sed 's/\"//g')"
    local UBOOTRELEASE="$(oe_runmake -C ${S} O=${outdir} -s ubootrelease | sed 's/\"//g')"
    printf '{\n  "ubootversion": "%s",\n  "ubootrelease": "%s"\n}\n' \
           "${UBOOTVERSION}" "${UBOOTRELEASE}" > "${outdir}/${outfile}"
}

do_compile:append () {
    # Get u-boot version and release using make (targets 'ubootversion' and 'ubootrelease');
    # some versions of u-boot have quotes in the string which are removed.
    if [ -n "${UBOOT_CONFIG}" ]; then
        unset i j
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]; then
                    generate_version_file "${B}/${config}" "u-boot-version.json-${type}"
                fi
            done
        done
    else
        generate_version_file "${B}" "u-boot-version.json"
    fi
}

deploy_version_file () {
    local indir=${1:?Missing input directory argument}
    local infile=${2:?Missing input file argument}
    local outdir=${3:?Missing output directory argument}
    local outfile=${4:?Missing output file argument}
    local stdoutfile=${5:-u-boot-version.json}
    install -D -m 0644 "${indir}/${infile}" "${outdir}/${outfile}"
    ln -sf "${outfile}" "${outdir}/${stdoutfile}"
}

do_deploy:append () {
    if [ -n "${UBOOT_CONFIG}" ]; then
        unset i j
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]; then
                    deploy_version_file \
                        "${B}/${config}" "u-boot-version.json-${type}" \
                        "${DEPLOYDIR}" "u-boot-version.json-${MACHINE}-${type}-${PV}-${PR}"
                fi
            done
        done
    else
        deploy_version_file \
            "${B}" "u-boot-version.json" \
            "${DEPLOYDIR}" "u-boot-version.json-${MACHINE}-${PV}-${PR}"
    fi
}
