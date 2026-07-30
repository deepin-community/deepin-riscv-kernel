#!/bin/bash

set -e

TARGET_TYPE=$1
TARGET_PROFILE=$2
ACTION_STAGE=$3

if [ "$TARGET_TYPE" != "kernel" ] && [ "$TARGET_TYPE" != "uboot" ]; then
  echo "error: invalid target type"
  exit 1
fi

if [ ! -f "./$TARGET_TYPE/profiles/$TARGET_PROFILE" ]; then
  echo "error: $TARGET_TYPE profile $TARGET_PROFILE not found"
  exit 1
fi

OUTPUT_DIR=$PWD/work/results
mkdir -p $OUTPUT_DIR

set -ex

# load default config
. ./utils/default.sh

# load functions
. ./utils/functions.sh

# load target config
. ./$TARGET_TYPE/profiles/$TARGET_PROFILE

if [ "$ACTION_STAGE" != "compile" ]; then

	# prepare stage
	sudo apt update
	exec_or_override ./utils/toolchain.sh
	exec_or_override ./utils/prep_install_cc.sh
	exec_or_override ./utils/prep_install_deps.sh
	exec_or_override ./utils/prep_config.sh
fi

if [ "$ACTION_STAGE" != "prepare" ]; then

	exec_or_override ./utils/compile_env.sh
	exec_or_override ./utils/$TARGET_TYPE/clone.sh
	WORKROOT=$PWD
	pushd work/$TARGET_TYPE
		exec_or_override $WORKROOT/utils/$TARGET_TYPE/patch.sh
		exec_or_override $WORKROOT/utils/$TARGET_TYPE/config.sh
		exec_or_override $WORKROOT/utils/$TARGET_TYPE/compile.sh
	popd

	exec_or_override ./utils/$TARGET_TYPE/cleanup.sh

	tree $OUTPUT_DIR
fi
