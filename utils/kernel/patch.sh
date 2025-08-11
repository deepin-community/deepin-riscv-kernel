#!/bin/bash

if [ ${#KERNEL_PATCHES[@]} -ne 0 ]; then
        for patchfile in "${KERNEL_PATCHES[@]}"; do
                if [ -f ../../kernel/patches/$patchfile ]; then
	                patch -p1 < ../../kernel/patches/$patchfile
		elif [[ $patchfile == http://* ]] || [[ $patchfile == https://* ]]; then
			patchfile_tmp=$(mktemp)
			wget $patchfile -O $patchfile_tmp
			patch -p1 < $patchfile_tmp
		else
			echo "error: patch $patchfile not found"
			exit 1
		fi
        done
fi

if [ ${#KERNEL_PATCHES_PROPRIETARY[@]} -ne 0 ]; then
        for patchfile in "${KERNEL_PATCHES_PROPRIETARY[@]}"; do
                if [ -f ../../proprietary-repo/kernel/patches/$patchfile ]; then
                        patch -p1 < ../../proprietary-repo/kernel/patches/$patchfile
                fi
        done
fi

if [ ! -z $KERNEL_BUILD_VERSION ]; then
	echo "echo $KERNEL_BUILD_VERSION" > init/build-version
	chmod -v +x init/build-version
fi
