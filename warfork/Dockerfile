# =================
# 资源下载
# =================
FROM cm2network/steamcmd AS downloader

RUN /home/steam/steamcmd/steamcmd.sh +quit
RUN /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +app_update 1136510 validate \
    +quit

# ===================
# 基座镜像
# ===================
FROM debian:trixie-slim AS base

EXPOSE 44400/udp 44444/tcp

RUN apt-get update && apt-get install -y --no-install-recommends \
    libstdc++6 \
    libcurl4 \
    zlib1g \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 gamesrv && \
    useradd -u 1000 -g gamesrv -m -s /bin/bash gamesrv
RUN mkdir -p /app && chown 1000:1000 /app
USER gamesrv

COPY --chown=1000:1000 --from=downloader ["/home/steam/steamcmd/linux64/steamclient.so", "/home/gamesrv/.steam/sdk64/steamclient.so"]
COPY --chown=1000:1000 --from=downloader ["/home/steam/Steam/steamapps/common/Dedicated Server", "/app"]
COPY --chown=1000:1000 ./patch/base /app

WORKDIR /app

# ===================
# 分支：双人对决
# ===================
FROM base AS versus

COPY --chown=1000:1000 ["./patch/dual/", "/app"]

CMD ["bash", "/app/start-server.sh"]