LINUX_VERSION ?= "4.18-rc8"

SRCREV = "1ffaddd029c867d134a1dde39f540dcc8c52e274"
SRCBRANCH = "master"

SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;protocol=https;branch=${SRCBRANCH};name=kernel \
           file://0001-mmc-sdhci-esdhc-imx-disable-irq-during-clock-change.patch \
           file://0001-ARM-dts-imx6qdl-colibri-mux-SD-MMC-card-detect-expli.patch \
           file://0002-ARM-dts-imx6qdl-colibri-move-card-detect-to-module-d.patch \
           file://0003-ARM-dts-imx6qdl-colibri-use-pull-down-on-wake-up-pin.patch \
           file://0001-mmc-sdhci-esdhc-imx-support-eMMC-DDR-mode-when-runni.patch \
           file://0001-ARM-dts-imx6q-apalis-add-chosen-node.patch \
           file://0002-ARM-dts-imx6q-apalis-eval-add-carrier-board-3.3V-sup.patch \
           file://0003-ARM-dts-imx6qdl-apalis-colibri-prevent-1.8V-modes.patch \
           file://0004-ARM-dts-imx6qdl-apalis-colibri-disable-read-only-swi.patch \
           file://0005-ARM-dts-imx6qdl-apalis-colibri-remove-1.8V-regulator.patch \
           file://0006-ARM-dts-imx6qdl-apalis-colibri-fix-on-module-regulat.patch \
           file://0007-ARM-dts-imx6qdl-apalis-colibri-assign-VDDD-to-SGTL50.patch \
           file://0008-ARM-dts-imx6qdl-apalis-colibri-remove-unused-pinctrl.patch \
           file://distro.scc \
           file://distro.cfg \
"

require recipes-kernel/linux/linux-lmp.inc
require recipes-kernel/linux/linux-lmp-machine-custom.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
