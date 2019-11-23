require image-common.inc
require torizon-core-common.inc

IMAGE_BASENAME_append_torizon-rt = "-rt"

IMAGE_FEATURES += "ssh-server-openssh"

# Enough free space for a full image update
IMAGE_OVERHEAD_FACTOR = "2.3"

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    coreutils \
    cpufrequtils \
    ldd \
    gptfdisk \
    hostapd \
    htop \
    iptables \
    ${@bb.utils.contains("MACHINE_FEATURES", "optee", "optee-test optee-client", "", d)} \
    rsync \
    sshfs-fuse \
    aktualizr-host-tools \
    curl \
    jq \
    zram \
"

CORE_IMAGE_BASE_INSTALL += " \
    less \
    openssh-sftp-server \
    packagegroup-core-full-cmdline-utils \
    packagegroup-core-full-cmdline-extended \
    packagegroup-core-full-cmdline-multiuser \
    python3-compression \
    python3-distutils \
    python3-docker \
    python3-json \
    python3-netclient \
    python3-pkgutil \
    python3-shell \
    python3-unixadmin \
    pciutils \
    strace \
    tcpdump \
    vim-tiny \
"

# docker pulls runc/containerd, which in turn recommend lxc unecessarily
BAD_RECOMMENDATIONS_append = " lxc"
