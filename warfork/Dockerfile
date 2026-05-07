FROM cm2network/steamcmd AS builder

RUN /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +app_update 1136510 validate \
    +quit


FROM cm2network/steamcmd

USER root
RUN mkdir -p /app && chown 1000:1000 /app
USER steam

WORKDIR /app
COPY --chown=1000:1000 --from=builder ["/home/steam/Steam/steamapps/common/Dedicated Server", "/app"]
COPY --chown=1000:1000 ./patch/ /app
RUN chmod +x /app/start-server.sh

EXPOSE 44400/udp 44444/tcp

CMD ["bash", "/app/start-server.sh"]