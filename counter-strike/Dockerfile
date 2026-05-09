FROM cm2network/steamcmd AS builder

RUN /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +app_set_config 90 mod cstrike \
    +app_update 90 -beta steam_legacy validate \
    +quit


FROM debian:trixie-slim

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        # 64-bit 依赖
        ca-certificates \
        # 32-bit 依赖
        libc6:i386 \
        libstdc++6:i386 \
        libgcc-s1:i386 \
        libcurl4:i386 \
        zlib1g:i386 \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 gamesrv && \
    useradd -u 1000 -g gamesrv -m -s /bin/bash gamesrv

RUN mkdir -p /app && chown 1000:1000 /app
USER gamesrv

WORKDIR /app
COPY --from=builder --chown=1000:1000 ["/home/steam/steamcmd/linux32/steamclient.so", "/home/gamesrv/.steam/sdk32/steamclient.so"]
COPY --from=builder --chown=1000:1000 ["/home/steam/Steam/steamapps/common/Half-Life", "/app"]
RUN rm -rf /app/valve/maps/*
COPY --chown=1000:1000 ["./patch/", "/app"]
RUN chmod +x /app/start-server.sh

EXPOSE 27015/udp 27015/tcp

VOLUME [ "/app/cstrike/maps" ]

CMD ["bash", "/app/start-server.sh"]