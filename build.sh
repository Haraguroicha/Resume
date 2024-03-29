#!/bin/bash

DIR=$( cd "$( dirname "$0" )" && pwd )
TARGET=${DIR}/build

mkdir -p "${TARGET}"
mkdir -p "${DIR}/src/data"

cd "${DIR}/src"

isDirty="$(git diff --quiet || echo '-dirty')"
shortVer="$(git rev-parse --short master)${isDirty}"

echo "AbbreviatedHash: ${shortVer}" > "${DIR}/src/data/rev.yaml"

HUGO_ENV=production HUGO_DISABLELANGUAGES="" hugo -b "/" --minify

cd "${DIR}"

cp -R {src/public,config} "${TARGET}/"

rm "${TARGET}/public/assets/css/"styles-*.css
rm "${TARGET}/public/index.html"
