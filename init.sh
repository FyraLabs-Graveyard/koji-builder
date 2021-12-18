#!/bin/bash
# This script will initialize the environment for the Koji Builder.
#
# mount the NFS share
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${NFS_SERVER}:/mnt/koji /mnt/koji

hostnamectl set-hostname $HOSTNAME

cp /opt/kojid.keytab /etc/krb5.keytab
cp /opt/kojid.conf /etc/kojid/kojid.conf

# finally start kojid
/usr/bin/kojid --verbose --fg --force-lock > /dev/stdout