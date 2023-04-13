TORADEX_MIRROR_URL="https://artifacts.toradex.com/artifactory/tdxref-torizoncore-sources-frankfurt/${TDX_MAJOR}"

PREMIRRORS_append () {
cvs://.*/.*     ${TORADEX_MIRROR_URL}
svn://.*/.*     ${TORADEX_MIRROR_URL}
git://.*/.*     ${TORADEX_MIRROR_URL}
gitsm://.*/.*   ${TORADEX_MIRROR_URL}
hg://.*/.*      ${TORADEX_MIRROR_URL}
bzr://.*/.*     ${TORADEX_MIRROR_URL}
p4://.*/.*      ${TORADEX_MIRROR_URL}
osc://.*/.*     ${TORADEX_MIRROR_URL}
https?$://.*/.* ${TORADEX_MIRROR_URL}
ftp://.*/.*     ${TORADEX_MIRROR_URL}
}
