# Docker Images

Custom docker images for my personal usage.

## Usage
#### Pull, customize, build, and run

Pull the published image, then build a local image when custom build arguments are needed:

```sh
docker pull ghcr.io/ibaydinn/docker-images/base-ubuntu:latest

docker build \
    --build-arg USERNAME=developer \
    --build-arg USER_UID=1000 \
    --build-arg USER_GID=1000 \
    --build-arg WORKSPACE=/workspace \
    -t base-ubuntu:custom images/base-ubuntu
```

Run the customized image:

```sh
export WORKDIR=<path_to_workdir>

docker run -d --privileged -it \
    --restart unless-stopped \
    --name <container_name> \
    -v "$WORKDIR:/workspace" \
    -p <host_port>:22 \
    base-ubuntu:custom
```

The image supports these build arguments:

| Argument | Default | Description |
| --- | --- | --- |
| `USERNAME` | `developer` | User created in the image and used as the default user. |
| `USER_UID` | `1000` | UID assigned to `USERNAME`. |
| `USER_GID` | `1000` | GID assigned to `USERNAME`. |
| `WORKSPACE` | `/workspace` | Workspace directory created for the user and used as `WORKDIR`. |

#### Run the published image with defaults

Docker pulls the image automatically when it is not available locally:

```sh
export WORKDIR=<path_to_workdir>

docker run -d --privileged -it \
    --restart unless-stopped \
    --name <container_name> \
    -v "$WORKDIR:/workspace" \
    -p <host_port>:22 \
    ghcr.io/ibaydinn/docker-images/base-ubuntu:latest
```

#### Connect to the container

SSH into the container using the username and port specified in the run command:
```sh
ssh <USERNAME>@localhost -p <host_port>
```

Docker exec into the container using the container name specified in the run command:
```sh
docker exec -it <container_name> bash
```

## Containers

### base-ubuntu
Basic ubuntu 22.04 based image with ssh server installed and configured. It is used as a base image for other images.
