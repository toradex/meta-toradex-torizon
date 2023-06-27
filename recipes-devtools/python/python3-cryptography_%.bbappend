
# fix the wrong triple
do_compile:prepend() {
    export CARGO_BUILD_TARGET="${RUST_HOST_SYS}"
}
