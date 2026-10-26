FROM ghcr.io/ibaydinn/docker-images/base-ubuntu:latest

ARG USERNAME=developer

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        clang \
        clang-format \
        clang-tidy \
        cppcheck \
        gdb \
        gnupg \
        git \
        lldb \
        ninja-build \
        pkg-config \
        valgrind \
    && wget -O /tmp/kitware-archive.asc \
        https://apt.kitware.com/keys/kitware-archive-latest.asc \
    && gpg --dearmor --output /usr/share/keyrings/kitware-archive-keyring.gpg \
        /tmp/kitware-archive.asc \
    && echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main" \
        > /etc/apt/sources.list.d/kitware.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends cmake \
    && rm -f /tmp/kitware-archive.asc \
    && rm -rf /var/lib/apt/lists/*

USER ${USERNAME}