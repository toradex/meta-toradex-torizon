require u-boot-ota.inc
require ${@ 'u-boot-secure-boot.inc' if 'secure-boot' in d.getVar('OVERRIDES').split(':') else ''}
