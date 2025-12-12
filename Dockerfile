FROM debian:unstable-slim

# Environment Variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ALLOW_IP=192.168.0.0
ENV SERVER_IP=192.168.0.100
ENV SANE_BACKEND_DLL=

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
                sane \
                sane-utils

# Entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

# Backup
RUN cp -rp /etc/sane.d /etc/sane.d.bak

# Services
RUN service saned restart

# Volume
VOLUME [ "/etc/sane.d" ]

# Ports
EXPOSE 6566
