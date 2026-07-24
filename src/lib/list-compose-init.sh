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

find "$ele_home" -type f \( -name 'compose-init.yaml' -o -name 'compose-init.yml' -o -name 'docker-compose-init.yaml' -o -name 'docker-compose-init.yml' \) \
	-exec dirname {} \; | sed "s|^$ele_home/||" | sort -u
