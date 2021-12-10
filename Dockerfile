FROM fedora:latest
RUN dnf install -y koji-builder koji-containerbuild-builder nfs-utils

RUN mkdir -p /mnt/koji

ENTRYPOINT [ "/opt/koji-builder/init.sh" ]