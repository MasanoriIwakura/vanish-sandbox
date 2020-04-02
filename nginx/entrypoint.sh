#!/bin/sh

sed "s/%HOST%/$HOST/g" -i /etc/nginx/conf.d/default.conf

/usr/sbin/nginx
