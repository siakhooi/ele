#!/bin/bash

usage() {
	echo "Usage: $(basename "$0") [-h]"
	echo " -h show this help"
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
ele_project=$(ele-config .cluster.project)
if [[ -z $ele_home ]]; then
	echo.error "Cluster home is not set. Please set it using 'ele-config-set .cluster.home <path>'"
	exit 1
fi
if [[ ! -d $ele_home ]]; then
	echo.error "Cluster home directory does not exist. ($ele_home)"
	exit 1
fi
if [[ -z $ele_project ]]; then
	echo.error "Cluster Project is not set. Please set it using 'ele-config-set .cluster.project <project>'"
	exit 1
fi


fileList=$(docker compose ls --format json |jq -r '.[]|select(.Name=="'"$ele_project"'")|.ConfigFiles')
IFS=', ' read -r -a fileArray <<<"$fileList"

for f in "${fileArray[@]}"; do
  f=${f/"$ele_home/"}
    dirname "$f"
done
