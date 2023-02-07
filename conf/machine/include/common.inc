
def check_machine(d):
    """Check if the MACHINE should uses meta-lmp or not"""
    if 'imx' in d.getVar('MACHINE'):
        return 'meta-lmp'
    else:
        return ''

BBMASK += " ${@check_machine(d)} "
