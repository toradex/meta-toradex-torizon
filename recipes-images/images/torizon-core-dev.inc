CORE_IMAGE_BASE_INSTALL:append = "\
    strace \
    tcpdump \
    gdbserver \
    perf \
    trace-cmd \
"

IMAGE_FEATURES:append = "\
    tools-debug \
    debug-tweaks \
    tools-testapps \
"
