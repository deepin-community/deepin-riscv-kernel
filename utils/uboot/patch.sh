#!/bin/bash

if [ ${#UBOOT_PATCHES[@]} -ne 0 ]; then
        for patchfile in "${UBOOT_PATCHES[@]}"; do
                if [ -f $BASEDIR/uboot/patches/$patchfile ]; then
	                patch -p1 < $BASEDIR/uboot/patches/$patchfile
		fi
        done
fi
