#!/bin/bash

SCRIPT_ARGS="$1"
DEFAULT_COMBO="userdebug"
DEFAULT_LINEAGE_OR_CM="lineage"
TARGET_DEVICE="a04br3"

if [ "$SCRIPT_ARGS" = "--clean" ]; then
    FORCE_CLEAN="true"
fi


setup_color() {  # Activate color codes.
    RED="\e[31m"
    GREEN="\e[32m"
    YELLOW="\e[33m"
    BLUE="\e[34m"
    RESET="\e[0m"   
}

run_command() {
    TARGET_CMD="$1"
    
    echo -e "${GREEN}-> $TARGET_CMD ${RESET}"
    $TARGET_CMD

    TARGET_CMD_EXIT_STAT="$?"
    if [ "$TARGET_CMD_EXIT_STAT" != "0" ]; then
        echo -e "${RED}[!!] ERROR: Command failed. return: $TARGET_CMD_EXIT_STAT $RESET"
        exit 1
    fi
}

prepare_env() { # env
    export LC_ALL="C"
    export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
    export KCFLAGS="-Wno-error=maybe-uninitialized"
    export USER="root"
    export ALLOW_MISSING_DEPENDENCIES="true"
    export ANDROID_NDK_TOOLCHAIN_PREFIX=aarch64-linux-android
    export ANDROID_NDK_TOOLS_PREFIX=aarch64-linux-android
}

main() {
    setup_color
    prepare_env
    
    echo -e "Starting build..."
    run_command ". build/envsetup.sh"

    run_command "lunch ${DEFAULT_LINEAGE_OR_CM}_${TARGET_DEVICE}-${DEFAULT_COMBO}"
    #run_command "mkdir -p out/target/product/${TARGET_DEVICE}/obj/KERNEL_OBJ/usr"
    
    if [ "$FORCE_CLEAN" = "true" ]; then
        run_command "make clean"
        exit 0
    fi

    run_command "brunch ${TARGET_DEVICE}"
    echo -e "${BLUE}Build successfull ${RESET}"

}


# start
main
