#!/bin/bash

if [ ! -z $UBOOT_SBI ]; then
        pushd ../sbi
                UBOOT_SBI_PLATFORM=${UBOOT_SBI_PLATFORM:-generic}
		if [ ! -z $UBOOT_SBI_PLATFORM_DEFCONFIG ]; then
			$MAKE_EXEC PLATFORM_DEFCONFIG=$UBOOT_SBI_PLATFORM_DEFCONFIG PLATFORM=$UBOOT_SBI_PLATFORM $UBOOT_SBI_MAKE_ARGS -j$(nproc)
		else
			$MAKE_EXEC PLATFORM=$UBOOT_SBI_PLATFORM $UBOOT_SBI_MAKE_ARGS -j$(nproc)
		fi
        	for UBOOT_SBI_RESULT_FILENAME in "${UBOOT_SBI_RESULT_FILENAMES[@]}"; do
                	find . -name "$UBOOT_SBI_RESULT_FILENAME" | xargs -I @ cp -av @ $OUTPUT_DIR/
        	done
	popd
fi

for UBOOT_DEFCONFIG in "${UBOOT_DEFCONFIGS[@]}"; do

echo "compile for $UBOOT_DEFCONFIG"

$MAKE_EXEC $UBOOT_DEFCONFIG

if [ ! -z $UBOOT_SBI ]; then
	$MAKE_EXEC OPENSBI="../sbi/build/platform/$UBOOT_SBI_PLATFORM/firmware/fw_dynamic.bin" -j$(nproc)
else
	$MAKE_EXEC -j$(nproc)
fi

UBOOT_OUTPUT_DIR=${UBOOT_DEFCONFIG%_defconfig}
mkdir -p $OUTPUT_DIR/${UBOOT_OUTPUT_DIR}

for UBOOT_RESULT_FILENAME in "${UBOOT_RESULT_FILENAMES[@]}"; do
	find . -name "$UBOOT_RESULT_FILENAME" | xargs -I @ cp -av @ $OUTPUT_DIR/${UBOOT_OUTPUT_DIR}/
done

$MAKE_EXEC clean

done

for MISC_RESULT_FILENAME in "${MISC_RESULT_FILENAMES[@]}"; do
	find . -name "$MISC_RESULT_FILENAME" | xargs -I @ cp -av @ $OUTPUT_DIR/
done
