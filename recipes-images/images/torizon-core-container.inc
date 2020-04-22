require torizon-core-common.inc

IMAGE_BASENAME_append_preempt-rt = "${IMAGE_RT_SUFFIX}"

IMAGE_FEATURES += "ssh-server-openssh"

# Enough free space for a full image update
IMAGE_OVERHEAD_FACTOR = "2.3"

# Base container packages
CORE_IMAGE_BASE_INSTALL_append = " \
    aktualizr-host-tools \
    ${@bb.utils.contains("MACHINE_FEATURES", "optee", "optee-test optee-client", "", d)} \
    coreutils \
    cpufrequtils \
    curl \
    gptfdisk \
    hostapd \
    htop \
    iptables \
    jq \
    ldd \
    less \
    openssh-sftp-server \
    ostree-devicetrees \
    ostree-kernel \
    ostree-initramfs \
    packagegroup-core-full-cmdline-multiuser \
    packagegroup-core-full-cmdline-utils \
    pciutils \
    python3-compression \
    python3-distutils \
    python3-docker \
    python3-json \
    python3-netclient \
    python3-pkgutil \
    python3-shell \
    python3-unixadmin \
    rsync \
    sshfs-fuse \
    strace \
    tcpdump \
    vim-tiny \
    zram \
"
