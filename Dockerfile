FROM eclipse-temurin:25-jdk

RUN apt-get update && apt-get install -y unzip curl
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /hytale
COPY ./setup.sh /opt/setup.sh
EXPOSE 5520/udp

CMD ["/bin/bash", "/opt/setup.sh"]