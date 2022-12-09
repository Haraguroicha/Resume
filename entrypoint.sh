#!/bin/bash

DIR=$( cd "$( dirname "$0" )" && pwd )
PATH=$DIR/sbin:$PATH

cd "${DIR}"

if [ $# -eq 0 ]; then
	exec nginx
else
	exec $*
fi
