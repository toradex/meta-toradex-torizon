
LINUX_VERSION = "5.15.92"

# use microhobby kernel Disable bt and use PL011 as console
SRCREV_machine = "361db6f664a26ca785fedf55f4d021a3fbdfd6dd"

SRC_URI = " \
    git://github.com/microhobby/linus-tree.git;name=machine;branch=${LINUX_RPI_BRANCH};protocol=https \
    git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=${LINUX_RPI_KMETA_BRANCH};destsuffix=${KMETA} \
    file://powersave.cfg \
    file://android-drivers.cfg \
"

require common.inc
