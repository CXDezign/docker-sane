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
                whois \
                nano \
                usbutils \
                git \
                cmake \
                g++ \
                sane \
                sane-utils \
                sane-airscan \
                libsane-dev \
                libjpeg-dev \
                libpng-dev \
                libavachi-client-dev \
                libusb-1.*-dev

# Entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

# Backup
RUN cp -rp /etc/sane.d /etc/sane.d.bak
RUN cp -rp /etc/airsane /etc/airsane.bak

# Volume
VOLUME [ "/etc/sane.d" ]
VOLUME [ "/etc/airsane" ]
VOLUME [ "/etc/default/airsane" ]

# Ports
EXPOSE 6566
EXPOSE 8090
