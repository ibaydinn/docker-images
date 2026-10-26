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
    -t base-ubuntu images/base-ubuntu
```
The image supports these build arguments:

| Argument | Default | Description |
| --- | --- | --- |
| `USERNAME` | `developer` | User created in the image and used as the default user. |
| `USER_UID` | `1000` | UID assigned to `USERNAME`. |
| `USER_GID` | `1000` | GID assigned to `USERNAME`. |
| `WORKSPACE` | `/workspace` | Workspace directory created for the user and used as `WORKDIR`. |

Run the customized image:
```sh
export WORKDIR=<path_to_workdir>

docker run -d --privileged -it \
    --restart unless-stopped \
    --name ubuntu-container \
    -v "$WORKDIR:/workspace" \
    -p 2222:22 \
    base-ubuntu
```

#### Run the published image with defaults

Docker pulls the image automatically when it is not available locally:

```sh
export WORKDIR=<path_to_workdir>

docker run -d --privileged -it \
    --restart unless-stopped \
    --name ubuntu-container \
    --hostname base-ubuntu \
    -v "$WORKDIR:/workspace" \
    -p 2222:22 \
    ghcr.io/ibaydinn/docker-images/base-ubuntu:latest
```

Run argument explanations:

| Argument | Meaning |
| --- | --- |
| `-d` | Runs the container in detached mode, in the background. |
| `--privileged` | Grants the container extended access to host devices and kernel capabilities. Use only when necessary. |
| `-i` | Keeps standard input open. |
| `-t` | Allocates a terminal (TTY). |
| `-it` | Combines `-i` and `-t` for interactive terminal access. |
| `--restart unless-stopped` | Automatically restarts the container unless it is explicitly stopped. |
| `--name <container_name>` | Assigns a name to the container. |
| `--hostname <hostname>` | Sets the hostname inside the container. |
| `-v <host_path>:<container_path>` | Mounts a host path into the container. |
| `-p <host_port>:<container_port>` | Publishes a container port on the host. |
| `<image>` | Specifies the image used to create the container. |

Together, `-d --privileged -it` runs a privileged container in the background while keeping it suitable for interactive access through `docker exec` or `docker attach`.




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
