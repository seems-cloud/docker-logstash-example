#!/bin/bash

sleep 3

while true ; do
  [ -f "/data/ca.crt.pem" ] && break
  sleep 1
done

cp /data/ca.crt.pem ./certs/

nxlog -c nxlog.conf -f