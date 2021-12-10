#!/bin/bash
# This script will initialize the environment for the Koji Builder.
#

# check the env variables
if [ -z "$NFS_SERVER" ]; then
    echo "NFS Server is not set! Exiting..."
    exit 1
fi

# mount the NFS share
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${NFS_SERVER}:/mnt/koji /mnt/koji


# check hostname var
if [ -z "$HOSTNAME" ]; then
    echo "HOSTNAME is not set! Exiting..."
    exit 1
fi
hostnamectl set-hostname $HOSTNAME

# check if /opt/kojid.conf exists
if [ ! -f "/opt/kojid.conf" ]; then
    echo "Koji config file is not found! Please mount one at /opt/kojid.conf"
    exit 1
fi

# check SSL or Kerberos keytab exists
if [ ! -f "/etc/krb5.keytab" ]; then
    export NOKEYTAB=1
fi

# check for SSL certificate
if [ ! -f "/etc/pki/koji/kojid.crt" ]; then
    export NOCERT=1
fi

# now for the fun part
# if both nokeytab and nocert are set, error out
if [ ! -z "$NOKEYTAB" ] && [ ! -z "$NOCERT" ]; then
    echo "No Kerberos keytab or SSL certificate found! Please mount one at /etc/krb5.keytab or /etc/pki/koji/kojid.crt"
    exit 1
elif [ ! -z "$NOKEYTAB" ]; then
    # copy the cert
    cp /opt/kojid.pem /etc/pki/koji/kojid.crt
elif [ ! -z "$NOCERT" ]; then
    # copy the keytab
    cp /opt/kojid.keytab /etc/krb5.keytab
fi

# finally start kojid
/usr/bin/kojid -c /opt/kojid.conf -v -f --force-lock