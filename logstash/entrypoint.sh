#!/bin/bash

openssl req -x509 -batch -nodes -newkey rsa:4096 -keyout certs/tcp5050.pem.key -out certs/tcp5050.pem.crt -subj /CN=logstash

logstash