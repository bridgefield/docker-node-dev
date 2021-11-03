ARG NODE_VERSION=12

FROM node:${NODE_VERSION}-alpine

WORKDIR /app

RUN apk --no-cache add \
    bash \
    unison \
    supervisor \
    inotify-tools \
    busybox-extras

COPY [ ".", "/" ]

ENV HOME=/tmp \
    UNISON_REPEAT=watch \
    UNISONLOCALHOSTNAME=localhost \
    START_COMMAND="npm-run" \
    NPM_RUN=serve \
    MONITOR_PACKAGES=true \
    AUTOSTART_APP=true \
    AUTOSTART_INETD=false \
    DELAY_START_PORT=""

RUN mkdir -p /state && chmod 1777 /state

VOLUME [ "/app", "/tmp" ]

CMD [ "sync-run" ]
