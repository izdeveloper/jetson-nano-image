FROM ubuntu:focal
RUN mkdir -p /scripts /rootfs
COPY create-rootfs.sh /scripts/
ENV JETSON_ROOTFS_DIR=/rootfs
RUN cd /scripts && ./create-rootfs.sh

RUN apt update && apt install -y python3-pip && pip3 install ansible

RUN mkdir -p /scripts/ansible /scripts/ansible/roles/jetson
COPY ansible/*.cfg /scripts/ansible/
COPY ansible/*.yaml /scripts/ansible/
COPY ansible/roles/jetson/ /scripts/ansible/roles/jetson
RUN cd /scripts/ansible/ && ansible-playbook jetson.yaml

RUN mkdir -p /scripts/ansible/roles/jetpack
COPY ansible/roles/jetpack/ /scripts/ansible/roles/jetpack
RUN cd /scripts/ansible/ && ansible-playbook jetpack.yaml
