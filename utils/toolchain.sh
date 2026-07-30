#!/bin/bash

extract_tarball() {
	local archive="$1"
	local dest="$2"
	local ext="${archive##*.}"

	case "$ext" in
		gz|tgz)
			tar -xzf "$archive" -C "$dest" --strip-components=1
			;;
		xz|txz)
			tar -xJf "$archive" -C "$dest" --strip-components=1
			;;
		bz2|tbz2)
			tar -xjf "$archive" -C "$dest" --strip-components=1
			;;
		zst|tzst)
			tar --zstd -xf "$archive" -C "$dest" --strip-components=1
			;;
		lz|tlz)
			tar --lzip -xf "$archive" -C "$dest" --strip-components=1
			;;
		lzma)
			tar --lzma -xf "$archive" -C "$dest" --strip-components=1
			;;
		*)
			# Try auto-detection
			tar -xaf "$archive" -C "$dest" --strip-components=1
			;;
	esac
}

if [ -n "$TOOLCHAIN" ]; then
	if [ -f "$TOOLCHAIN" ]; then
		echo "Extracting toolchain from $TOOLCHAIN ..."
		toolchain_dir="$PWD/work/toolchain"
		rm -rf "$toolchain_dir"
		mkdir -p "$toolchain_dir"
		extract_tarball "$TOOLCHAIN" "$toolchain_dir"
		export PATH="$toolchain_dir/bin:$PATH"
		echo "Toolchain extracted to $toolchain_dir, PATH updated"
	elif [ -d "$TOOLCHAIN" ]; then
		echo "Using toolchain directory $TOOLCHAIN ..."
		export PATH="$TOOLCHAIN/bin:$PATH"
		echo "PATH updated with $TOOLCHAIN/bin"
	else
		toolchain_url="$TOOLCHAIN"
		toolchain_dir="$PWD/work/toolchain"
		toolchain_archive="$PWD/work/toolchain.tar"
		echo "Downloading toolchain from $toolchain_url ..."
		rm -rf "$toolchain_dir" "$toolchain_archive"*
		mkdir -p "$toolchain_dir"
		wget -q "$toolchain_url" -O "$toolchain_archive"
		echo "Extracting toolchain ..."
		extract_tarball "$toolchain_archive" "$toolchain_dir"
		rm -f "$toolchain_archive"
		export PATH="$toolchain_dir/bin:$PATH"
		echo "Toolchain extracted to $toolchain_dir, PATH updated"
	fi
fi
