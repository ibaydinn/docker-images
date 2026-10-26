FROM ubuntu:22.04

# Set arguments for the user to be created
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=1000
ARG WORKSPACE=/workspace

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm-256color \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash bash-completion ca-certificates curl locales procps sudo tar wget \
    openssh-server nano \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /etc/ssh/ssh_host_* 

RUN mkdir -p /run/sshd \
    && echo 'PermitRootLogin no' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config \
    && echo 'UsePAM yes' >> /etc/ssh/sshd_config \
    && echo "AllowUsers ${USERNAME}" >> /etc/ssh/sshd_config

RUN groupadd --gid "${USER_GID}" "${USERNAME}" \
    && useradd \
        --uid "${USER_UID}" \
        --gid "${USER_GID}" \
        --create-home \
        --shell /bin/bash \
        "${USERNAME}" \
    && printf '%s ALL=(ALL) NOPASSWD:ALL\n' "${USERNAME}" \
        > "/etc/sudoers.d/${USERNAME}" \
    && chmod 0440 "/etc/sudoers.d/${USERNAME}"

# Set password for the user (default is 'root')
RUN echo "${USERNAME}:root" | chpasswd

# Create workspace directory
RUN mkdir -p ${WORKSPACE} \
    && chown "${USER_UID}:${USER_GID}" ${WORKSPACE}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set developer as default user
USER ${USERNAME}
WORKDIR ${WORKSPACE}

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]