#!/bin/bash

trap custom_terminate HUP INT QUIT KILL EXIT TERM
function custom_terminate() {
  killall apache2
  exit 0
}

rm -f /var/run/apache2/apache2.pid
service apache2 start

while true; do sleep 1; done
