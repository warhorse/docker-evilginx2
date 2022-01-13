# [warhorse/docker-evilginx2](https://github.com/war-horse/docker-evilginx2)

![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/warhorse/docker-evilginx2)
[![CI](https://github.com/warhorse/docker-evilginx2/workflows/Docker/badge.svg?event=push)](https://github.com/warhorse/docker-evilginx2/actions?query=workflow%3ADocker)
![License](https://img.shields.io/github/license/warhorse/docker-evilginx2)
![Commit](https://img.shields.io/github/last-commit/warhorse/docker-evilginx2)

[Evilginx2](https://github.com/kgretzky/evilginx2) - Standalone man-in-the-middle attack framework used for phishing login credentials along with session cookies, allowing for the bypass of 2-factor authentication


![Evilginx2](https://raw.githubusercontent.com/kgretzky/evilginx2/master/media/img/evilginx2-logo-512.png)

## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=evilginx2 \
  -e TZ=Europe/London \
  -p 443:443 \
  -p 80:80 \
  -v <path to data>:/config \
  -v <path to data>:/phishlets 
  --restart unless-stopped \
  warhorse/evilginx2
```

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  evilginx2:
    image: warhorse/evilginx2
    container_name: evilginx2
    environment:
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
      - <path to data>:/phishlets
    ports:
      - 443:443
      - 80:80
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | The port for HTTP traffic |
| `-p 443` | The port for HTTPS traffic |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London|
| `-v /config` | evilginx2 configs |
| `-v /phishlets` | evilginx2 phishlets |

&nbsp;
## Application Setup

Access the webui at `<your-ip>:7443`, for more information check out [evilginx2](https://github.com/kgretzky/evilginx2).



## Support Info

* Shell access whilst the container is running: `docker exec -it evilginx2 /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f evilginx2`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:
```
git clone https://github.com/warhorse/docker-evilginx2.git
cd docker-evilginx2
docker build \
  --no-cache \
  --pull \
  -t warhorse/evilginx2:latest .
```
## Versions

* **02.13.20:** - First Push