#!/bin/bash

DIR=$( cd "$( dirname "$0" )" && pwd )
TARGET=${DIR}/.build

mkdir -p "${TARGET}"

cd "${DIR}/src"

HUGO_ENV=production hugo -b "/"

cd "${DIR}"

cp -R {src/public,config,run-server,Procfile} "${TARGET}/"
