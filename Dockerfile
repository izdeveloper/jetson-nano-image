FROM ubuntu:focal
ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y python3-pip && pip3 install ansible
RUN apt-get install --no-install-recommends -y qemu-user-static debootstrap binfmt-support coreutils parted wget gdisk e2fsprogs libxml2-utils
RUN mkdir -p /scripts /rootfs
COPY create-rootfs.sh /scripts/
ENV JETSON_ROOTFS_DIR=/rootfs
RUN cd /scripts && ./create-rootfs.sh


RUN mkdir -p /scripts/ansible /scripts/ansible/roles/jetson
COPY ansible/*.cfg /scripts/ansible/
COPY ansible/*.yaml /scripts/ansible/
COPY ansible/roles/jetson/ /scripts/ansible/roles/jetson
RUN cd /scripts/ansible/ && ansible-playbook jetson.yaml
ENV JETSON_NANO_BOARD=jetson-nano
ENV JETSON_NANO_REVISION=300
ENV JETSON_BUILD_DIR=/builddir
ENV BSP=https://developer.nvidia.com/embedded/l4t/r32_release_v7.1/t210/jetson-210_linux_r32.7.1_aarch64.tbz2
# COPY ansible/roles/jetpack /scripts/ansible/roles/
# RUN cd /scripts/ansible/ && ansible-playbook jetpack.yaml

COPY create-image.sh /scripts
RUN mkdir -p $JETSON_BUILD_DIR && wget -qO- $BSP | tar -jxpf - -C $JETSON_BUILD_DIR
RUN apt update && apt install -y vim
RUN apt update && apt install -y sudo
ENV USER=root
#RUN cd /scripts && ./create-image.sh
