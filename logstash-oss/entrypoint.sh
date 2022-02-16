#!/bin/bash

sleep 3

while true ; do
  [ -f "/data/${HOSTNAME}.crt.pem" ] && [ -f "/data/${HOSTNAME}.key.pem" ] && break
  sleep 1
done

cp /data/ca.crt.pem ./certs/
cp /data/"${HOSTNAME}".crt.pem ./certs/
cp /data/"${HOSTNAME}".key.pem ./certs/

logstash