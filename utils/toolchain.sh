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

if [ ${#TOOLCHAIN[@]} -gt 0 ]; then
	idx=0
	for tc in "${TOOLCHAIN[@]}"; do
		if [ -f "$tc" ]; then
			echo "Extracting toolchain from $tc ..."
			toolchain_dir="$PWD/work/toolchain-$idx"
			rm -rf "$toolchain_dir"
			mkdir -p "$toolchain_dir"
			extract_tarball "$tc" "$toolchain_dir"
			export PATH="$toolchain_dir/bin:$PATH"
			echo "Toolchain extracted to $toolchain_dir, PATH updated"
		elif [ -d "$tc" ]; then
			echo "Using toolchain directory $tc ..."
			export PATH="$tc/bin:$PATH"
			echo "PATH updated with $tc/bin"
		else
			toolchain_url="$tc"
			toolchain_dir="$PWD/work/toolchain-$idx"
			toolchain_archive="$PWD/work/toolchain-$idx.tar"
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
		idx=$((idx + 1))
	done
fi
