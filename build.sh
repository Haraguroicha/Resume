#!/bin/bash

DIR=$( cd "$( dirname "$0" )" && pwd )
TARGET=${DIR}/.build

mkdir -p "${TARGET}"
mkdir -p "${DIR}/src/data"

cd "${DIR}/src"

isDirty="$(git diff --quiet || echo '-dirty')"
shortVer="$(git rev-parse --short master)${isDirty}"

echo "AbbreviatedHash: ${shortVer}" > "${DIR}/src/data/rev.yaml"

HUGO_ENV=production hugo -b "/"

cd "${DIR}"

rm "${DIR}/src/public/assets/css/"styles-*.css

cp -R {src/public,config,run-server,Procfile} "${TARGET}/"
