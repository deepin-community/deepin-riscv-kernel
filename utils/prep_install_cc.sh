#!/bin/bash

if [ "$CC_TYPE" == "gcc" ]; then

if [ "$(arch)" != "$CC_ARCH" ]; then

  sudo apt install -y g++-${GCC_VER}-${CC_ARCH}-linux-gnu

  sudo update-alternatives --install /usr/bin/${CC_ARCH}-linux-gnu-gcc ${CC_ARCH}-gcc /usr/bin/${CC_ARCH}-linux-gnu-gcc-${GCC_VER} 10
  sudo update-alternatives --install /usr/bin/${CC_ARCH}-linux-gnu-g++ ${CC_ARCH}-g++ /usr/bin/${CC_ARCH}-linux-gnu-g++-${GCC_VER} 10

else

  sudo apt install -y g++-${GCC_VER}

fi

fi

if [ "$CC_TYPE" == "clang" ]; then
    sudo apt install -y clang lld llvm
fi
