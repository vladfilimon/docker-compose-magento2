#!/bin/bash

trap custom_terminate HUP INT QUIT KILL EXIT TERM
function custom_terminate() {
  killall apache2
  exit 0
}

if [ ! -f /var/www/html/fb_host_probe.txt ]; then
    echo "server active" > /var/www/html/fb_host_probe.txt
fi

if [ ! -f /var/www/html/pub/fb_host_probe.txt ]; then
    echo "server active" > /var/www/html/pub/fb_host_probe.txt
fi

rm -f /var/run/apache2/apache2.pid
service apache2 start

while true; do sleep 1; done
