#!/bin/sh

adduser -D -h /var/ftp alesanto
echo "alesanto:password" | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf