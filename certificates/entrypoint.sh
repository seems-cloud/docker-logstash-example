#!/bin/bash

rm -rf data/*

mkdir -p data/

# Create CA
openssl req -nodes -x509 -days 3650 -newkey rsa:4096 -subj "/C=US/ST=Mazovia/L=Warsaw/O=Seems Cloud/OU=Root" \
  -keyout ./ca/RootCA.key.pem -out ./data/ca.crt.pem

# Create CSR
openssl req -nodes -new -newkey rsa:2048 -subj "/CN=logstash" \
  -keyout ./data/logstash.key.pem -out ./csr/Logstash.csr.pem

openssl req -nodes -new -newkey rsa:2048 -subj "/CN=logstash-oss" \
  -keyout ./data/logstash-oss.key.pem -out ./csr/LogstashOSS.csr.pem

# Sign CSR
openssl x509 -req -days 365 \
  -CA ./data/ca.crt.pem -CAkey ./ca/RootCA.key.pem -CAcreateserial \
  -in ./csr/Logstash.csr.pem -out ./data/logstash.crt.pem

openssl x509 -req -days 365 \
  -CA ./data/ca.crt.pem -CAkey ./ca/RootCA.key.pem -CAcreateserial \
  -in ./csr/LogstashOSS.csr.pem -out ./data/logstash-oss.crt.pem