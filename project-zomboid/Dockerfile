# =================
# 资源下载
# =================
FROM cm2network/steamcmd AS downloader

RUN /home/steam/steamcmd/steamcmd.sh +quit
RUN /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +app_update 380870 validate \
    +quit

# ===================
# 基座镜像
# ===================
FROM eclipse-temurin:25-jre AS base

EXPOSE 16261/udp 16262/tcp

USER 1000:1000

COPY --from=downloader --chown=1000:1000 ["/home/steam/Steam/steamapps/common/Project Zomboid Dedicated Server", "/app"]

ENV TZ=Asia/Shanghai

WORKDIR /app

# ===================
# 分支：原版
# ===================
FROM base AS vanilla

COPY --chown=1000:1000 ["./patch/", "/app"]

CMD ["bash", "/app/start-server.sh", "-nosteam"]
