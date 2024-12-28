ARG GITIT_VERSION=0.15.1.2

FROM haskell:slim-bullseye
LABEL maintainer="eins78 <1@178.is>"

ENV GITIT_VERSION=${GITIT_VERSION}

RUN git clone https://github.com/jgm/gitit && \
    cd gitit && \
    git checkout ${GITIT_VERSION} && \
    stack install

VOLUME ["/data"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /data

EXPOSE 5001

CMD ["gitit", "-f", "/data/gitit.conf"]
