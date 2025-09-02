#!/bin/bash

if [ "$GCC_ARCH" != "x86_64" ]; then
  export DEB_BUILD_PROFILES="pkg.linux-upstream.nokernelheaders"
else
  export KERNEL_ENABLE_MODULES=1
fi

$MAKE_EXEC bindeb-pkg -j$(nproc) LOCALVERSION="-${TARGET_PROFILE}"
