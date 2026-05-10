FROM alpine:latest AS builder

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads
RUN wget https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.8.4_Server_Java_17-25.zip
RUN unzip ./GT_New_Horizons_2.8.4_Server_Java_17-25.zip -d gtnh

FROM eclipse-temurin:25-jre

RUN mkdir -p /app && chown 1000:1000 /app
USER 1000:1000

WORKDIR /app

COPY --from=builder --chown=1000:1000 ["/downloads/gtnh", "/app"]
COPY --chown=1000:1000 ["./patch/", "/app"]

ENV TZ=Asia/Shanghai

EXPOSE 25565/tcp
EXPOSE 25575/tcp

VOLUME [ "/app/World" ]
VOLUME [ "/app/backups" ]
VOLUME [ "/app/Journeymap" ]
VOLUME [ "/app/tcnodetracker" ]

CMD ["bash", "/app/start-server.sh"]