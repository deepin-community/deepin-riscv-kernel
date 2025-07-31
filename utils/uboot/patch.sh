#!/bin/bash

if [ ${#UBOOT_PATCHES[@]} -ne 0 ]; then
        for patchfile in "${UBOOT_PATCHES[@]}"; do
                if [ -f ../../uboot/patches/$patchfile ]; then
	                patch -p1 < ../../uboot/patches/$patchfile
		fi
        done
fi
