#!/bin/sh
service php7.2-fpm start
nginx -g 'daemon off; error_log /dev/stdout info;' 