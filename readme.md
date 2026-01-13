# Hytale Server Docker Container

This project provides a Dockerized environment for running a Hytale server. 
It automatically handles the downloading and setup of the Hytale server files whenever the container starts if they are not already present.

## Features

- **Automatic Setup**: Checks for existing server files; if missing, it downloads the official Hytale downloader and retrieves the server files.
- **Java 25**: Built on `eclipse-temurin:25-jdk`.
- **Persistence**: All server data, logs, and configuration are persisted in the local `hytale/` directory.

## Getting Started

1. **Access the Server**:
   The server listens on **UDP port 5520**.

## Configuration

### Data Persistence

The docker-compose configuration maps a local folder to the container to persist data:
- `./hytale:/hytale`: This directory will contain the downloader, server executables, configuration files (`config.json`, `permissions.json`), worlds, and logs.

### Ports
- **5520/udp**: The default port for the Hytale server.

## Directory Structure

After initialization, your `/hytale/` directory will look similar to this:

```
hytale/
├── downloader/     # Contains the Hytale downloader tool
├── server/         # The main server installation
│   ├── Server/     # Configs, binaries, and runtime files
│   └── ...         # Server files
└── ...
```

