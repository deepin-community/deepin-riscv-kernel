#!/bin/bash

if [ -z "${CROSS_COMPILE+xxx}" ]; then
  if [ "$(arch)" != "$GCC_ARCH" ]; then
    export CROSS_COMPILE="${GCC_ARCH}-linux-gnu-"
    if [ -z $NOCCACHE ]; then
      export CROSS_COMPILE="ccache ${CROSS_COMPILE}"
    fi
  fi
fi

case $GCC_ARCH in
	riscv64)
		MAKE_ARCH="riscv"
		;;
	aarch64)
		[ "$TARGET_TYPE" != "kernel" ] || MAKE_ARCH="arm64"
		[ "$TARGET_TYPE" != "uboot" ] || MAKE_ARCH="arm"
		;;
	*)
		MAKE_ARCH="${GCC_ARCH}"
		;;
esac

export MAKE_EXEC="make ARCH=${MAKE_ARCH}"


