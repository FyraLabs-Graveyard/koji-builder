FROM gitlab.ultramarine-linux.org:5050/release-engineering/oci-images/lapis
RUN microdnf install -y koji-builder koji-containerbuild-builder nfs-utils koji-osbuild rpmautospec koji-builder-plugins

RUN mkdir -p /mnt/koji
ADD init.sh /opt/koji-builder/init.sh

ENTRYPOINT [ "/opt/koji-builder/init.sh" ]