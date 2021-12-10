FROM gitlab.ultramarine-linux.org:5050/release-engineering/oci-images/lapis
RUN dnf install -y koji-builder koji-containerbuild-builder nfs-utils

RUN mkdir -p /mnt/koji

ENTRYPOINT [ "/opt/koji-builder/init.sh" ]