# =================
# 资源下载
# =================
FROM alpine:latest AS downloader

RUN apk add --no-cache \
    wget \
    unzip

WORKDIR /downloads
RUN wget https://github.com/Pryaxis/TShock/releases/download/v6.1.0/TShock-6.1.0-for-Terraria-1.4.5.6-linux-x64-Release.zip
RUN unzip ./TShock-6.1.0-for-Terraria-1.4.5.6-linux-x64-Release.zip
RUN tar -xf TShock-Beta-linux-x64-Release.tar -C /downloads

# ===================
# 基座镜像
# ===================
FROM mcr.microsoft.com/dotnet/runtime:9.0

EXPOSE 7777/tcp

VOLUME [ "/app/tshock" ]

RUN groupadd -g 1000 gamesrv && \
    useradd -u 1000 -g gamesrv -m -s /bin/bash gamesrv
RUN mkdir -p /app/tshock && chown -R 1000:1000 /app
USER 1000:1000

COPY --from=downloader --chown=1000:1000 ["/downloads","/app"]
COPY --chown=1000:1000 ./patch/ /app/

WORKDIR /app

CMD ["bash", "/app/start-server.sh"]