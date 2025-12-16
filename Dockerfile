FROM debian:unstable-slim

# Environment Variables
ENV DEBIAN_FRONTEND=noninteractive

# Labels
LABEL org.opencontainers.image.source="https://github.com/CXDezign/docker-sane"
LABEL org.opencontainers.image.description="Dockerized Scan (SANE) Server"
LABEL org.opencontainers.image.author="CXDezign <contact@cxdezign.com>"
LABEL org.opencontainers.image.url="https://github.com/CXDezign/docker-sane/blob/main/README.md"
LABEL org.opencontainers.image.licenses=MIT

# Dependencies
RUN apt update -qqy
RUN apt upgrade -qqy
RUN apt install --no-install-recommends -y \
		systemd \
                whois \
                nano \
                usbutils \
                ca-certificates \
                git \
                cmake \
		build-essential \
                g++ \
                sane \
                sane-utils \
                sane-airscan \
                avahi-daemon \
                libusb-1.0-0-dev \
                libjpeg-dev \
                libpng-dev \
                libsane-dev \
                libavahi-client-dev \
		libavahi-client3

# Volume
VOLUME [ "/etc/sane.d" ]
VOLUME [ "/etc/airsane" ]

# Ports
EXPOSE 6566
EXPOSE 8090

# Work Directory
WORKDIR /opt/airsane

# Entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--access-log=-", "--debug=true", "--reset-option=true", "--local-scanners-only=false"]
