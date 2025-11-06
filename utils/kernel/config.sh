#!/bin/bash

KERNEL_DEFCONFIG=${KERNEL_DEFCONFIG:-defconfig}
 
$MAKE_EXEC $KERNEL_DEFCONFIG
            
if [ ${#KERNEL_EXTRA_CONFIGS[@]} -ne 0 ]; then
	concat_config=$(mktemp)
	for configfile in "${KERNEL_EXTRA_CONFIGS[@]}"; do
		if [ -f $BASEDIR/kernel/defconfigs/$configfile ]; then
			cat $BASEDIR/kernel/defconfigs/$configfile >> $concat_config
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
