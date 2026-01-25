FROM debian:unstable-slim

# Environment Variables
ENV DEBIAN_FRONTEND=noninteractive

# Dependencies
RUN apt update -qqy && \
	apt upgrade -qqy && \
	apt install --no-install-recommends -y \
				systemd \
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
EXPOSE 8090

# Work Directory
WORKDIR /opt/airsane

# Entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--access-log=-", "--debug=true", "--reset-option=true", "--local-scanners-only=false"]
