#!/bin/bash

KERNEL_DEFCONFIG=${KERNEL_DEFCONFIG:-defconfig}
 
if [ ! -z $KERNEL_DEFCONFIG_USE ]; then
	cp ../../kernel/defconfigs/$KERNEL_DEFCONFIG_USE arch/riscv/configs/
	KERNEL_DEFCONFIG=$KERNEL_DEFCONFIG_USE
fi

if [ ! -z $KERNEL_CONFIGS_FROM_DEBIAN ]; then
	curl https://salsa.debian.org/kernel-team/linux/-/raw/debian/latest/debian/config/riscv64/config >> arch/riscv/configs/$KERNEL_DEFCONFIG
fi

$MAKE_EXEC $KERNEL_DEFCONFIG
            
if [ ${#KERNEL_EXTRA_CONFIGS[@]} -ne 0 ]; then
	concat_config=$(mktemp)
	for configfile in "${KERNEL_EXTRA_CONFIGS[@]}"; do
		if [ -f ../../kernel/defconfigs/$configfile ]; then
			cat ../../kernel/defconfigs/$configfile >> $concat_config
		fi
	done

	scripts/kconfig/merge_config.sh -m .config $concat_config
fi

# version config
sed -i '/CONFIG_LOCALVERSION_AUTO/d' .config && echo "CONFIG_LOCALVERSION_AUTO=n" >> .config
sed -i '/CONFIG_LOCALVERSION=/d' .config

# debug config

if [ ! -z $KERNEL_ENABLE_DEBUG ]; then
	echo "CONFIG_DEBUG_INFO_DWARF5=y" >> .config
fi

# module config

if [ ! -z $KERNEL_ENABLE_MODULES ]; then
	echo "CONFIG_MODULES=y" >> .config
fi

# If config restart, use default config
$MAKE_EXEC olddefconfig

