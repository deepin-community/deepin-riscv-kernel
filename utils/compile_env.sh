#!/bin/bash

if [ "$CC_TYPE" == "gcc" ]; then

if [ -z "${CROSS_COMPILE+xxx}" ]; then
  if [ "$(arch)" != "$CC_ARCH" ]; then
    export CROSS_COMPILE="${CC_ARCH}-linux-gnu-"
    if [ -z $NOCCACHE ]; then
      export CROSS_COMPILE="ccache ${CROSS_COMPILE}"
    fi
  fi
fi

fi

case $CC_ARCH in
	riscv64)
		MAKE_ARCH="riscv"
		;;
	aarch64)
		[ "$TARGET_TYPE" != "kernel" ] || MAKE_ARCH="arm64"
		[ "$TARGET_TYPE" != "uboot" ] || MAKE_ARCH="arm"
		;;
	*)
		MAKE_ARCH="${CC_ARCH}"
		;;
esac

export MAKE_EXEC="make ARCH=${MAKE_ARCH}"

if [ "$CC_TYPE" == "llvm" ]; then
    export MAKE_EXEC="$MAKE_EXEC LLVM=1"
fi
