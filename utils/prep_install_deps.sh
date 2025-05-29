#!/bin/bash

sudo apt install -y \
	tree \
	build-essential \
	gdisk \
	dosfstools \
	libncurses-dev \
	gawk \
	flex \
	bison \
	openssl \
	libssl-dev \
	dkms \
	libelf-dev \
	pahole \
	libudev-dev \
	libpci-dev \
	libiberty-dev \
	autoconf \
	mkbootimg \
	fakeroot \
	genext2fs \
	genisoimage \
	libconfuse-dev \
	mtd-utils \
	mtools \
	squashfs-tools \
	device-tree-compiler \
	rauc \
	u-boot-tools \
	swig \
	ccache \
	debhelper \
	libdw-dev

if [ "$TARGET_TYPE" == "uboot" ]; then
          sudo apt install -y qemu-utils qemu-utils f2fs-tools arm-trusted-firmware-tools libgnutls28-dev uuid-dev
fi
