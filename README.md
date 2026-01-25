# Docker SANE
# Description
Run Dockerised Scanner server to share USB scanners over the network. \
Built to be used with Raspberry Pi's. \
Tested and confirmed to be working on:
- Raspberry Pi 5 (`arm64/AArch64`)

## Usage
1. Clone this repository:
```bash
git clone https://github.com/CXDezign/docker-cups.git
```
2. Build the Docker image:
```bash
docker build -t docker-cups .
```
3. Create a `docker-compose.yml` file with the following content, adjusting parameters as needed:
```yaml
services:
    sane:
        container_name: sane
        image: docker-sane
        restart: unless-stopped
        ports:
            - 8090:8090
        volumes:
            - /etc/sane.d:/etc/sane.d
            - /etc/airsane:/etc/airsane
        devices:
            - /dev/bus/usb:/dev/bus/usb
```
4. Use **Docker Compose** to run the Docker image in a container.
```bash
docker-compose up -d
```

## Parameters & Environment Variables
| Parameter          | Default                                               | Description |
| ------------------ | ----------------------------------------------------- | ----------- |
| `container_name`   | `sane`                                                | Preferred Docker container name. |
| `ports`            | `8090`                                                | AIRSANE network port. |
| `volumes`          | `/etc/sane.d`, `/etc/airsane`                         | Persistent Docker container volume for configuration files (migration or backup purposes). |
| `devices`          | `/dev/bus/usb:/dev/bus/usb`                           | Add host device (USB scanner) to container. Default passes the whole USB bus in case the USB port on your device changes. Change to a fixed USB port if it will remain unchanged, example: `/dev/bus/usb/001/005`. |

## Access
AIRSANE web app will be accessible on the defined port of the host machine.
```
http://<DOCKER_HOST_IP>:8090
```

## Documentation
[SANE](http://www.sane-project.org/man/sane.7.html) \
[SANE Daemon](http://www.sane-project.org/man/saned.8.html) \
[SANE USB](http://www.sane-project.org/man/sane-usb.5.html) \
[SANE Network](http://www.sane-project.org/man/sane-net.5.html) \
[SANE Find Scanner](http://www.sane-project.org/man/sane-find-scanner.1.html) \
[SANE Backend DLLs](http://www.sane-project.org/man/sane-dll.5.html) \
[SANE Server Configuration](https://wiki.debian.org/SaneOverNetwork#Server_Configuration) \
[AIRSANE](https://github.com/SimulPiscator/AirSane)
