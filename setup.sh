#!/bin/sh
set -e

prefix="[DOCKER_SETUP] "

if [ -f "/hytale/server/Server/HytaleServer.jar" ]; then
    echo "${prefix} Hytale server already set up, skipping setup."
else
    echo "${prefix} Hytale server not found, running setup..."
    if [ ! -d "/hytale/downloader" ]; then
        mkdir -p /hytale/downloader
    fi

    ## Download Hytale downloader
    if [ -f "/hytale/downloader/hytale-downloader-linux-amd64" ]; then
        echo "${prefix} Hytale downloader already exists, skipping download."
    else
        curl -o /hytale/downloader/hytale-downloader.zip https://downloader.hytale.com/hytale-downloader.zip 
        unzip /hytale/downloader/hytale-downloader.zip -d /hytale/downloader
        rm /hytale/downloader/hytale-downloader.zip /hytale/downloader/hytale-downloader-windows-amd64.exe
        chmod +x /hytale/downloader/hytale-downloader-linux-amd64
    fi

    ## 
    if [ ! -d "/hytale/server" ]; then
        mkdir -p /hytale/server
    fi

    /hytale/downloader/hytale-downloader-linux-amd64 -download-path /hytale/server/server.zip
fi

if [ -f "/hytale/server/Server/HytaleServer.jar" ]; then
    echo "${prefix} Server already exists, skipping unzip."
elif [ -f "/hytale/server/server.zip" ]; then
    echo "${prefix} Unzipping server.zip..."
    unzip /hytale/server/server.zip -d /hytale/server
    chmod +x /hytale/server/Server/HytaleServer.jar
else
    echo "${prefix} server.zip not found!"
    exit 1
fi

if [ ! -f "/hytale/server/Assets.zip" ]; then
    echo "${prefix} Assets.zip not found!"
    exit 1
fi

if [ ! -d "/hytale/instance" ]; then
    echo "${prefix} Creating instance directory..."
    mkdir -p /hytale/instance
fi

cd /hytale/instance
echo "${prefix} Starting Hytale server..."
java -jar /hytale/server/Server/HytaleServer.jar --assets /hytale/server/Assets.zip --boot-command "auth login device"