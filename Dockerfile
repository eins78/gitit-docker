ARG GITIT_VERSION=0.15.1.2
ARG DEBIAN_VERSION=bullseye

FROM haskell:${DEBIAN_VERSION} AS build
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

FROM debian:${DEBIAN_VERSION}-slim AS prod

ENV GITIT_VERSION=${GITIT_VERSION}

COPY --from=build /gitit/.stack-work /gitit/.stack-work
COPY --from=build /root/.local/bin/gitit /usr/local/bin/
COPY --from=build /root/.local/bin/expireGititCache /usr/local/bin/

VOLUME ["/data"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /data

EXPOSE 5001

CMD ["gitit", "-f", "/data/gitit.conf"]
