# Minecraft Server Builder (GitHub Actions)

This repo lets you build a vanilla Minecraft Java server package for **any version**
(release or snapshot) straight from GitHub, no local downloads needed.

## Setup

1. Create a new GitHub repository (or use an existing one).
2. Copy this repo's files into it, preserving the path:
   ```
   .github/workflows/build-mc-server.yml
   Dockerfile        (optional, only needed if you want to run it via Docker)
   README.md
   ```
3. Commit and push.

## Building a server

1. Go to your repo on GitHub → **Actions** tab.
2. Select **"Build Minecraft Server"** in the left sidebar.
3. Click **"Run workflow"**.
4. Fill in the inputs:
   - **mc_version**: e.g. `1.21.1`, `1.20.4`, `1.8.9`, or `latest` / `latest-snapshot`
   - **accept_eula**: must be `true` if you actually want to run the server (this
     means you accept Mojang's EULA: https://www.minecraft.net/en-us/eula)
   - **motd**, **difficulty**, **gamemode**: optional basic settings
5. Click the green **"Run workflow"** button.
6. When the run finishes (usually under a minute), open it and download the
   **minecraft-server-<version>** artifact from the bottom of the run summary page.

## Running the server you built

GitHub Actions itself **cannot host a live server players can join** — runners
have no public inbound network access and jobs auto-terminate. This workflow
only *builds and packages* the server. To actually host it:

- **Locally**: unzip the artifact, run `./start.sh` (Linux/macOS) or
  `start.bat` (Windows), then port-forward 25565 or use a tunnel tool
  (ngrok, playit.gg, Tailscale Funnel) so friends can connect.
- **On a VPS/cloud VM**: upload the unzipped folder, install a matching Java
  version, run `start.sh`, open port 25565 in the firewall.
- **Via Docker**: unzip the artifact into a folder named `server/` next to the
  `Dockerfile`, then:
  ```bash
  docker build -t my-mc-server .
  docker run -d -p 25565:25565 --name mc my-mc-server
  ```

## Java version notes

- Minecraft 1.20.5+ → Java 21
- Minecraft 1.18 – 1.20.4 → Java 17
- Minecraft 1.17 → Java 16
- Minecraft ≤ 1.16 → Java 8 (the workflow's Docker image uses Java 21 — swap
  the base image tag if you're building an older version)

## Notes

- This only builds the **vanilla** server jar. For modded servers (Forge,
  Fabric, Paper, Spigot), the download logic differs — say the word and I can
  adapt the workflow for one of those instead.
- Memory flags in `start.sh`/`start.bat` (`-Xmx2G -Xms1G`) should be adjusted
  to whatever RAM the host machine actually has.
