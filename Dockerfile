ARG NODE_VERSION=12

FROM node:${NODE_VERSION}-alpine

WORKDIR /app

RUN apk --no-cache add \
    bash \
    unison \
    supervisor

COPY [ ".", "/" ]

ENV HOME=/tmp \
    UNISONLOCALHOSTNAME=localhost \
    START_COMMAND="/bin/bash -c 'sleep 3 && exec npm-run'" \
    NPM_RUN=serve

VOLUME [ "/app", "/tmp" ]

CMD [ "sync-run" ]
