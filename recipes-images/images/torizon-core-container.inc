require torizon-core-common.inc

IMAGE_FEATURES += "ssh-server-openssh bash-completion-pkgs"

# Enough free space for a full image update
IMAGE_OVERHEAD_FACTOR = "2.3"

# Base container packages
CORE_IMAGE_BASE_INSTALL_append = " \
    cpufrequtils \
    curl \
    htop \
    jq \
    ldd \
    less \
    openssh-sftp-server \
    packagegroup-core-full-cmdline-multiuser \
    packagegroup-core-full-cmdline-utils \
    rsync \
    sshfs-fuse \
    strace \
    tcpdump \
    vim-tiny \
    zram \
"
