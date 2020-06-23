FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

python () {
    srcurl = d.getVar('SRC_URI').replace('go%s.src.tar.gz' % d.getVar('PV'), 'go1.14.src.tar.gz')
    d.setVar('SRC_URI', srcurl)
}

SRC_URI_remove = "file://0001-release-branch.go1.12-security-net-textproto-don-t-n.patch file://0010-fix-CVE-2019-17596.patch"

SRC_URI[main.md5sum] = "7c97bdb3b5218a5089612efb3ed30345"
SRC_URI[main.sha256sum] = "6d643e46ad565058c7a39dac01144172ef9bd476521f42148be59249e4b74389"
