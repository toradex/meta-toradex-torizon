LINUX_VERSION ?= "4.17.3"

SRCREV = "83e05c58300605f3ab87819c19d1822f54eff81e"
SRCBRANCH = "linux-4.17.y"

SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;protocol=https;branch=${SRCBRANCH};name=kernel \
           file://0001-mmc-sdhci-esdhc-imx-disable-irq-during-clock-change.patch \
           file://0001-ARM-dts-imx6qdl-colibri-mux-SD-MMC-card-detect-expli.patch \
           file://0002-ARM-dts-imx6qdl-colibri-move-card-detect-to-module-d.patch \
           file://0003-ARM-dts-imx6qdl-colibri-use-pull-down-on-wake-up-pin.patch \
           file://0001-mmc-sdhci-esdhc-imx-support-eMMC-DDR-mode-when-runni.patch \
           file://distro.scc \
           file://distro.cfg \
"

require recipes-kernel/linux/linux-lmp.inc
require recipes-kernel/linux/linux-lmp-machine-custom.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(colibri-imx7|colibri-imx6)"
