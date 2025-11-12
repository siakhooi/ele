#!/bin/bash

set -e
# shellcheck disable=SC1091
source ./release.env

readonly full_name=$COMPONENT_NAME-$RELEASE_VERSION

readonly build_root=target
readonly build_home=$build_root/$full_name
readonly source_home=src
readonly deb_file="${build_home}.deb"

mkdir -p "$build_home"
rm -rf "${build_home:?}"/*

# Control File
cp -vr $source_home/DEBIAN "$build_home"

# Binary File
readonly build_bin_home=$build_home/usr/bin
mkdir -p "$build_bin_home"

find $source_home/bin -type f -exec cp -vr {} "$build_bin_home" \;

chmod 755 "$build_bin_home"/*

fakeroot dpkg-deb --build -Zxz "$build_home"
# dpkg-name ${deb_file}

sha256sum "$deb_file" >"$deb_file.sha256sum"
sha512sum "$deb_file" >"$deb_file.sha512sum"

dpkg --contents "$deb_file"
