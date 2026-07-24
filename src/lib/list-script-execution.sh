#!/bin/bash

usage() {
	echo "Usage: $(basename "$0") [-h]"
}
while getopts "h" arg; do
	case $arg in
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
if [[ $# -ne 0 ]]; then
	usage
	exit 0
fi

ele_home=$(ele-config .cluster.home)

if [[ -z $ele_home ]]; then
	echo.error "Cluster home is not set. Please set it using 'ele-config-set .cluster.home <path>'"
	exit 1
fi

if [[ ! -d $ele_home ]]; then
	echo.error "Cluster home directory does not exist. ($ele_home)"
	exit 1
fi

# Find all subdirectories (multilevel) containing .exec.sh files
find "$ele_home" -type f -name '*.exec.sh' | sed "s|^$ele_home/||" | sed "s|\.exec\.sh$||" | sort -u
