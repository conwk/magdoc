#!/usr/bin/env sh
chown -R nobody:nobody /var/www 
chown -R nginx:nginx /var/www /var/tmp/nginx
php-fpm7 --daemonize
nginx -g 'daemon off;'
