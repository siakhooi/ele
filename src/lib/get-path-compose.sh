#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "Usage: $(basename "$0") compose_filename" >&2
	exit 0
fi

compose_filename=$1

ele_home=$(ele-config .cluster.home)
if [[ -z $ele_home ]]; then
	echo.error "Cluster home is not set. Please set it using 'ele-config-set .cluster.home <path>'"
	exit 1
fi
if [[ ! -d $ele_home ]]; then
	echo.error "Cluster home directory does not exist. ($ele_home)"
	exit 1
fi

file="$ele_home/$compose_filename/compose.yaml"
if [[ -f $file ]]; then
	echo "$file"
	exit 0
fi
file="$ele_home/$compose_filename/compose.yml"
if [[ -f $file ]]; then
	echo "$file"
	exit 0
fi
file="$ele_home/$compose_filename/docker-compose.yaml"
if [[ -f $file ]]; then
	echo "$file"
	exit 0
fi
file="$ele_home/$compose_filename/docker-compose.yml"
if [[ -f $file ]]; then
	echo "$file"
	exit 0
fi
echo "Compose file not exists." >&2
exit 1
