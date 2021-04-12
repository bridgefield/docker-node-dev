#!/bin/bash

if [[ "$(stat -f -c %T  /app)" == "ext2/ext3" ]] && [ -n "$SKIP_SYNC_ON_FAST_FS" ]; then
  echo "no need for sync"
  cd /app
  exec /bin/bash /run.sh
fi

mkdir -p /tmp/app/ /tmp/.unison
cd /tmp/.unison
ln -s /*.prf .

cd /tmp
exec supervisord
