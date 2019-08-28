#!/bin/bash

DIR=$( cd "$( dirname "$0" )" && pwd )
TARGET=${DIR}/.build

mkdir -p "${TARGET}"

cd "${DIR}/src"

isDirty="`git diff --quiet || echo '-dirty'`"
shortVer="`git rev-parse --short master`${isDirty}"

if [ "${isDirty}" != "" ]; then
    rm "${DIR}/src/data/rev.yaml"
fi

if [ ! -f "${DIR}/src/data/rev.yaml" ]; then
    echo "AbbreviatedHash: ${shortVer}" > "${DIR}/src/data/rev.yaml"
fi

HUGO_ENV=production hugo -b "/"

cd "${DIR}"

cp -R {src/public,config,run-server,Procfile} "${TARGET}/"
