#!/bin/bash

export GIT_CLONE_PROTECTION_ACTIVE=false

mkdir -p work

if [ ! -d work/uboot ]; then

git clone --depth=1 -b "${UBOOT_BRANCH:-master}" "${UBOOT_GIT:-https://github.com/u-boot/u-boot.git}" work/uboot

if [ ! -z $UBOOT_SUBDIR ]; then
	mv work/uboot work/uboot-git
	mv work/uboot-git/${UBOOT_SUBDIR} work/uboot
fi

if [ ! -z $UBOOT_SBI ]; then
	git clone --depth=1 -b "${UBOOT_SBI_BRANCH:-master}" "${UBOOT_SBI_GIT:-https://github.com/riscv/opensbi.git}" work/sbi
fi

fi
