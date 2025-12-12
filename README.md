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
| Flag                  | Parameter          | Default                     | Description |
| --------------------- | ------------------ | --------------------------- | ----------- |
| `--name`              | `container_name:`  | `sane`                      | Preferred Docker container name. |
| `--device`            | `devices:`         | `/dev/bus/usb:/dev/bus/usb` | Add host device (USB scanner) to container. Default passes the whole USB bus in case the USB port on your device changes. Change to a fixed USB port if it will remain unchanged, example: `/dev/bus/usb/001/005`. |
| `-v`                  | `volumes:`         | `/etc/sane.d`               | Persistent Docker container volume for SANE configuration files (migration or backup purposes). |
| `-p`                  | `ports:`           | `6566`                      | SANE network port. |
| `-e ALLOW_IP`         | `ALLOW_IP`         | `192.168.0.0`               | Environment allowed IP addresses for remote connection. |
| `-e SERVER_IP`        | `SERVER_IP`        | `192.168.0.100`             | Environment server IP. |
| `-e SANE_PORT`        | `SANE_PORT`        | `6566`                      | Environment SANE network port. |
| `-e SANE_BACKEND_DLL` | `SANE_BACKEND_DLL` | ` `                         | Environment SANE backend DLLs. Use your preferred backend DLLs [Backend DLLs](http://www.sane-project.org/man/sane-dll.5.html). |

## Docker Run
```bash
docker run -d --name sane \
    --restart unless-stopped \
    --device /dev/bus/usb \
    -p 6566:6566 \
    -v /etc/sane.d:/etc/sane.d \
    -e ALLOW_IP=192.168.0.0 \
    -e SERVER_IP=192.168.0.100 \
    -e SANE_PORT=6566 \
    -e SANE_BACKEND_DLL= \
    cxdezign/docker-sane
```

## Docker Compose
```yaml
services:
    sane:
        image: cxdezign/docker-sane
        container_name: sane
        restart: unless-stopped
        ports:
            - 6566:6566
        devices:
            - /dev/bus/usb:/dev/bus/usb
        environment:
            - ALLOW_IP=192.168.0.0
            - SERVER_IP=192.168.0.100
            - SANE_PORT=6566
            - SANE_BACKEND_DLL=
        volumes:
            - /etc/sane.d:/etc/sane.d
```

## SANE Documentation
[SANE](http://www.sane-project.org/man/sane.7.html)
[USB](http://www.sane-project.org/man/sane-usb.5.html)
[Find Scanner](http://www.sane-project.org/man/sane-find-scanner.1.html)
[Backend DLLs](http://www.sane-project.org/man/sane-dll.5.html)
