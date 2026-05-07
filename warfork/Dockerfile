FROM cm2network/steamcmd AS builder

RUN /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +app_update 1136510 validate \
    +quit


FROM debian:trixie-slim

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

WORKDIR /app
COPY --chown=1000:1000 --from=builder ["/home/steam/steamcmd/linux64/steamclient.so", "/home/gamesrv/.steam/sdk64/steamclient.so"]
COPY --chown=1000:1000 --from=builder ["/home/steam/Steam/steamapps/common/Dedicated Server", "/app"]
COPY --chown=1000:1000 ./patch/ /app
RUN chmod +x /app/start-server.sh

EXPOSE 44400/udp 44444/tcp

CMD ["bash", "/app/start-server.sh"]