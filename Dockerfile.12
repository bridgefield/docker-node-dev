ARG NODE_VERSION=12

FROM node:${NODE_VERSION}-alpine

WORKDIR /app

RUN apk --no-cache add \
    bash \
    unison \
    supervisor

COPY [ ".", "/" ]

ENV HOME=/tmp \
    NPM_RUN=serve

VOLUME [ "/app", "/tmp" ]

CMD [ "/sync-run.sh" ]
