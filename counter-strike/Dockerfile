FROM cm2network/steamcmd AS builder

RUN /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +app_set_config 90 mod cstrike \
    +app_update 90 -beta steam_legacy validate \
    +quit


FROM cm2network/steamcmd

USER root
RUN mkdir -p /app && chown 1000:1000 /app
USER steam

WORKDIR /app
COPY --chown=1000:1000 --from=builder /home/steam/Steam/steamapps/common/Half-Life /app
COPY --chown=1000:1000 ./patch/ /app
RUN chmod +x /app/start-server.sh

EXPOSE 27015/udp 27015/tcp

CMD ["bash", "/app/start-server.sh"]