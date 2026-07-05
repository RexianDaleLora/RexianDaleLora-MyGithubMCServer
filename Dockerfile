# Build with: docker build -t my-mc-server .
# Then extract a "minecraft-server-<version>" artifact from the GitHub Action
# into a folder named "server/" next to this Dockerfile before building,
# OR pass --build-arg to have this fetch a version directly (see below).

FROM eclipse-temurin:21-jre-jammy

WORKDIR /minecraft

# Copy in the server files produced by the build-mc-server.yml workflow
# (download the artifact, unzip it, place contents in ./server before building)
COPY server/ /minecraft/

RUN chmod +x /minecraft/start.sh

EXPOSE 25565

CMD ["./start.sh"]
