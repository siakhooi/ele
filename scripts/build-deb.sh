#!/usr/bin/env bash
#
# Description: Build a Debian package from the source files.
# Usage: ./build-deb.sh [options]
#

set -euo pipefail

# shellcheck disable=SC1091
source ./release.env
# shellcheck disable=SC1091
source ./build.env

# ===== Constants =====
# readonly build_home=target
# readonly source_home=src
readonly full_name=$PACKAGE_NAME-$RELEASE_VERSION
readonly build_root=target
readonly build_home=$build_root/$full_name
readonly source_home=src

# ===== Argument Parsing =====
parse_args() {
	while getopts "h" opt; do
		case "${opt}" in
		h)
			usage
			exit 0
			;;
		*)
			usage
			exit 1
			;;
		esac
	done
	shift $((OPTIND - 1))
}

# ===== Helper Functions =====
prepare_directory() {
	mkdir -p "$build_home"
	rm -rf "${build_home:?}"/*
}
copy_control_files() {
	cp -vr $source_home/DEBIAN "$build_home"
}
copy_binary_files() {
	readonly build_bin_home=$build_home/usr/bin
	mkdir -p "$build_bin_home"

	find $source_home/bin -type f -exec cp -vr {} "$build_bin_home" \;
	chmod 755 "$build_bin_home"/*
}
copy_lib_files() {
	readonly build_lib_home=$build_home/usr/lib/ele
	mkdir -p "$build_lib_home"
	cp -vr $source_home/lib/* "$build_lib_home"
	chmod 755 "$build_lib_home"/*
}
build_deb_package() {
	fakeroot dpkg-deb --build -Zxz "$build_home"
}
rename_deb_package() {
	dpkg-name "${build_home}.deb"
}
generate_checksums() {
	DEBFILE=$(ls ./target/*.deb)

	mv -v "$DEBFILE" .
	deb_file=$(basename "$DEBFILE")
	sha256sum "$deb_file" >"$deb_file.sha256sum"
	sha512sum "$deb_file" >"$deb_file.sha512sum"

}
list_deb_contents() {
	dpkg --contents "$deb_file"
}
# ===== Main Logic =====
main() {

	parse_args "$@"

	prepare_directory

	copy_control_files
	copy_binary_files
	copy_lib_files

	build_deb_package
	rename_deb_package

	generate_checksums

}
# ===== Entrypoint =====
main "$@"
