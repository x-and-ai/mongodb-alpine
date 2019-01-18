FROM alpine:3.8

RUN apk add --no-cache mongodb=3.6.7-r0 && \
    mkdir -p /data/db && \
    chown -R mongodb /data/db

VOLUME [ "/data/db" ]

EXPOSE 27017

USER mongodb 

CMD mongod --bind_ip 0.0.0.0 