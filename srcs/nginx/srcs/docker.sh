#!/bin/sh

rc-status
rc-service nginx start
rc-status

/etc/init.d/sshd start &

nginx -s stop
nginx -g 'daemon off;'