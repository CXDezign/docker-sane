# Description

Run Dockerised Scan server to share USB scanners over the network. \
Built to be used with Raspberry Pi's. \
Tested and confirmed to be working on:
- Raspberry Pi 5 (`arm64/AArch64`)

Image package available from:
  - [Docker Hub](https://hub.docker.com/repository/docker/cxdezign/docker-sane): `cxdezign/docker-sane`

# Usage
Use either **Docker Run** or **Docker Compose** to run the Docker image in a container with customised parameters.

## Parameters
| Flag          | Parameter         | Default                     | Description |
| ------------- | ----------------- | --------------------------- | ----------- |
| `--name`      | `container_name:` | `sane`                      | Preferred Docker container name. |
| `--device`    | `devices:`        | `/dev/bus/usb:/dev/bus/usb` | Add host device (USB scanner) to container. Default passes the whole USB bus in case the USB port on your device changes. Change to a fixed USB port if it will remain unchanged, example: `/dev/bus/usb/001/005`. |
| `-v`          | `volumes:`        | `sane.d`                    | Persistent Docker container volume for SANE configuration files (migration or backup purposes). |
| `-p`          | `ports:`          | `6566`                      | SANE network port. |

## Docker Run
```bash
docker run -d --name sane \
    --restart unless-stopped \
    --device /dev/bus/usb \
    -p 6566:6566 \
    -v /etc/sane.d:/etc/sane.d \
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
        volumes:
            - /etc/sane.d:/etc/sane.d
```
