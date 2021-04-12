#!/bin/bash

make_checksum() {
    DIR_CHECKSUM=$(find node_modules -name package.json -type f -exec md5sum {} \; | sort -k 2 | md5sum | cut -d' ' -f1)
    PACK_CHECKSUM=$(md5sum package.json package-lock.json  | md5sum | cut -d' ' -f1)
    echo "$DIR_CHECKSUM-$PACK_CHECKSUM"
}

set -e
if [ -d node_modules ]; then
    CURRENT_CHECKSUM="$(make_checksum)"
    SAVED_CHECKSUM="missing"
    if [ -e "package-installed.checksum" ]; then
        SAVED_CHECKSUM="$(cat package-installed.checksum)"
    fi
    if [[ "$CURRENT_CHECKSUM" != "$SAVED_CHECKSUM" ]]; then
        echo "Something changed"
        FORCE_INSTALL=1
    fi
fi

if [ ! -d node_modules ] || [ -n "$FORCE_INSTALL" ]; then
    echo "Installing npm packages"
    npm ci --also=dev
    echo -n $(make_checksum) > package-installed.checksum
fi

exec npm run $NPM_RUN
