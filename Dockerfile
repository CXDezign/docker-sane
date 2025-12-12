FROM debian:unstable-slim

# Environment Variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ALLOW_IP=192.168.0.0
ENV SERVER_IP=192.168.0.100
ENV SANE_PORT=6566
ENV SANE_BACKEND_DLL=

# Labels
LABEL org.opencontainers.image.source="https://github.com/CXDezign/docker-sane"
LABEL org.opencontainers.image.description="Dockerized Scan (SANE) Server"
LABEL org.opencontainers.image.author="CXDezign <contact@cxdezign.com>"
LABEL org.opencontainers.image.url="https://github.com/CXDezign/docker-sane/blob/main/README.md"
LABEL org.opencontainers.image.licenses=MIT

# Dependencies (Packages & Drivers)
RUN apt update -qqy
RUN apt upgrade -qqy
RUN apt install --no-install-recommends -y \
                whois \
                nano \
                usbutils \
                sane

# Service SANE
RUN service saned start

# SANE Default Configuration
RUN echo "RUN=yes" >> /etc/default/saned
RUN echo "data_portrange = ${SANE_PORT}" >> /etc/sane.d/cupsd.conf
RUN echo "${ALLOW_IP}" >> /etc/sane.d/cupsd.conf
RUN echo "net" >> /etc/sane.d/dll.conf
RUN echo "${SANE_BACKEND_DLL}" >> /etc/sane.d/dll.conf
RUN echo "${SERVER_IP}" >> /etc/sane.d/net.conf

# Entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

# Backup
RUN cp -rp /etc/sane.d /etc/sane.d.bak

# Service Daemon
#RUN saned -l -e

# Volume
VOLUME [ "/etc/sane.d" ]

# Ports
EXPOSE ${SANE_PORT}
