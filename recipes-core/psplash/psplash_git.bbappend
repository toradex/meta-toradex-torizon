FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

DEPENDS += "systemd"

SRC_URI += " \
    file://psplash-start.service \
    file://torizon-blue-splash.patch \
    file://0001-use-run-for-communication-fifo.patch \
    file://0002-process-consecutive-commands.patch \
    file://0003-add-systemd-support.patch \
"

SPLASH_IMAGES = "file://torizon-blue.png;outsuffix=default"

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES','systemd','${PN}','',d)}"
SYSTEMD_SERVICE_${PN} += "${@bb.utils.contains('DISTRO_FEATURES','systemd','psplash-start.service','',d)}"

python do_compile () {
    import shutil
    import subprocess

    # Build a separate executable for each splash image
    workdir = d.getVar('WORKDIR')
    convertscript = "%s/make-image-header.sh" % d.getVar('S')
    destfile = "%s/psplash-poky-img.h" % d.getVar('S')
    localfiles = d.getVar('SPLASH_LOCALPATHS').split()
    outputfiles = d.getVar('SPLASH_INSTALL').split()
    for localfile, outputfile in zip(localfiles, outputfiles):
        if localfile.endswith(".png"):
            subprocess.call([ convertscript, os.path.join(workdir, localfile), 'POKY' ], cwd=workdir)
            fbase = os.path.splitext(localfile)[0]
            shutil.copyfile(os.path.join(workdir, "%s-img.h" % fbase), destfile)
        else:
            shutil.copyfile(os.path.join(workdir, localfile), destfile)
        # For some reason just updating the header is not enough, we have to touch the .c
        # file in order to get it to rebuild
        os.utime("%s/psplash.c" % d.getVar('S'), None)
        bb.build.exec_func("oe_runmake", d)
        shutil.copyfile("psplash", outputfile)
}

do_install_append () {
	install -d ${D}${systemd_unitdir}/system
	install -m 644 ${WORKDIR}/*.service ${D}/${systemd_unitdir}/system
}
