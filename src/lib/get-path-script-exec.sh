#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "Usage: $(basename "$0") exec_name" >&2
	exit 0
fi

exec_name=$1

ele_home=$(ele-config .cluster.home)
if [[ -z $ele_home ]]; then
	echo.error "Cluster home is not set. Please set it using 'ele-config-set .cluster.home <path>'"
	exit 1
fi
if [[ ! -d $ele_home ]]; then
	echo.error "Cluster home directory does not exist. ($ele_home)"
	exit 1
fi

file="$ele_home/${exec_name}.exec.sh"
if [[ -e $file ]]; then
	echo "$file"
	exit 0
fi

echo "Exec file not executable/exists." >&2
exit 1
