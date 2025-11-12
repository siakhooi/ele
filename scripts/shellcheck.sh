#!/bin/bash

set -e

find src/bin -type f -exec shellcheck {} \;
