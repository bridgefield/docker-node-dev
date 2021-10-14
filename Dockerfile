ARG NODE_VERSION=12

FROM node:${NODE_VERSION}-alpine

WORKDIR /app

RUN apk --no-cache add \
    bash \
    unison \
    supervisor \
    inotify-tools

COPY [ ".", "/" ]

ENV HOME=/tmp \
    UNISONLOCALHOSTNAME=localhost \
    START_COMMAND="npm-run" \
    NPM_RUN=serve \
    MONITOR_PACKAGES=true

VOLUME [ "/app", "/tmp" ]

CMD [ "sync-run" ]
