#!/bin/bash

openssl req -x509 -batch -nodes -newkey rsa:4096 -keyout certs/tcp5050.key -out certs/tcp5050.cert -subj /CN=logstash