EXTRA_OECONF_append = " --enable-fhs-media"

do_install_append() {
    # udisks2 service by default is wanted by graphical.target, change it to multi-user.target.
    sed -i -e 's/WantedBy=.*/WantedBy=multi-user.target/' ${D}${systemd_system_unitdir}/${BPN}.service

    # Enable UDISKS_FILESYSTEM_SHARED, so the mount base directory would be /media instead of /media/$USER.
    echo -e "\n# Enable UDISKS_FILESYSTEM_SHARED\nENV{UDISKS_FILESYSTEM_SHARED}=\"1\"" >> ${D}${nonarch_base_libdir}/udev/rules.d/80-udisks2.rules
}
