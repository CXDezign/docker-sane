# Description

Run Dockerised Scan server to share USB scanners over the network. \
Built to be used with Raspberry Pi's. \
Tested and confirmed to be working on:
- Raspberry Pi 5 (`arm64/AArch64`)

Image package available from:
  - [Docker Hub](https://hub.docker.com/repository/docker/cxdezign/docker-sane): `cxdezign/docker-sane`

# Usage
Use either **Docker Run** or **Docker Compose** to run the Docker image in a container with customised parameters.

## Parameters & Environment Variables
| Flag                  | Parameter          | Default                                               | Description |
| --------------------- | ------------------ | --------------------------------------- | ----------- |
| `--name`              | `container_name:`  | `sane`                                                | Preferred Docker container name. |
| `-p`                  | `ports:`           | `6566`, `8090`                                        | SANE & AIRSANE network ports. |
| `-v`                  | `volumes:`         | `/etc/sane.d`, `/etc/airsane`, `/etc/default/airsane` | Persistent Docker container volume for SANE configuration files (migration or backup purposes). |
| `--device`            | `devices:`         | `/dev/bus/usb:/dev/bus/usb`                           | Add host device (USB scanner) to container. Default passes the whole USB bus in case the USB port on your device changes. Change to a fixed USB port if it will remain unchanged, example: `/dev/bus/usb/001/005`. |

## Docker Run
```bash
docker run -d --name sane \
    --restart unless-stopped \
    -p 8090:8090 \
    -v /etc/sane.d:/etc/sane.d \
    -v /etc/airsane:/etc/airsane \
    --device /dev/bus/usb \
    cxdezign/docker-sane
```

## Docker Compose
```yaml
services:
    sane:
        container_name: sane
        image: cxdezign/docker-sane
        restart: unless-stopped
        ports:
            - 8090:8090
        volumes:
            - /etc/sane.d:/etc/sane.d
            - /etc/airsane:/etc/airsane
        devices:
            - /dev/bus/usb:/dev/bus/usb
```

## SANE Documentation
[SANE](http://www.sane-project.org/man/sane.7.html) \
[SANE Daemon](http://www.sane-project.org/man/saned.8.html) \
[SANE USB](http://www.sane-project.org/man/sane-usb.5.html) \
[SANE Network](http://www.sane-project.org/man/sane-net.5.html) \
[SANE Find Scanner](http://www.sane-project.org/man/sane-find-scanner.1.html) \
[SANE Backend DLLs](http://www.sane-project.org/man/sane-dll.5.html) \
[SANE Server Configuration](https://wiki.debian.org/SaneOverNetwork#Server_Configuration) \
[AIRSANE](https://github.com/SimulPiscator/AirSane)
