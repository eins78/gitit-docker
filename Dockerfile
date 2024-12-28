ARG GITIT_VERSION=0.15.1.2

FROM haskell:bullseye
LABEL maintainer="eins78 <1@178.is>"
LABEL org.opencontainers.image.url="https://github.com/jgm/gitit"
LABEL org.opencontainers.image.source="https://github.com/eins78/gitit-docker"
LABEL org.opencontainers.image.version=${GITIT_VERSION}

ENV GITIT_VERSION=${GITIT_VERSION}

RUN apt-get update && apt-get install -y build-essential pkg-config && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/jgm/gitit && \
    cd gitit && \
    git checkout ${GITIT_VERSION} && \
    stack --install-ghc install

VOLUME ["/data"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /data

EXPOSE 5001

CMD ["gitit", "-f", "/data/gitit.conf"]
