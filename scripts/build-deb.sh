#!/bin/bash

set -ex
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
cp -vr $source_home/DEBIAN "$build_root"

# Binary File
readonly build_bin_home=$build_home/usr/bin
mkdir -p "$build_bin_home"

find $source_home/bin -type f -exec cp -vr {} "$build_bin_home" \;

chmod 755 "$build_bin_home"/*

fakeroot dpkg-deb --build -Zxz "$build_root"
dpkg-name ${build_root}.deb

DEBFILE=$(ls ./*.deb)

sha256sum "$DEBFILE" >"$DEBFILE.sha256sum"
sha512sum "$DEBFILE" >"$DEBFILE.sha512sum"

dpkg --contents "$DEBFILE"
