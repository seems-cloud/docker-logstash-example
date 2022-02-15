#!/bin/bash

mkdir -p data/{logstash,logstash-oss}

# Create CA
openssl req -nodes -x509 -days 3650 -newkey rsa:4096 -subj "/C=US/ST=Mazovia/L=Warsaw/O=Seems Cloud/OU=Root" \
  -keyout ./ca/RootCA.key.pem -out ./ca/RootCA.crt.pem

# Create CSR
openssl req -nodes -new -newkey rsa:2048 -subj "/CN=logstash" \
  -keyout ./data/logstash/logstash.key.pem -out ./csr/Logstash.csr.pem

openssl req -nodes -new -newkey rsa:2048 -subj "/CN=logstash-oss" \
  -keyout ./data/logstash-oss/logstash.key.pem -out ./csr/LogstashOSS.csr.pem

# Sign CSR
openssl x509 -req -days 365 \
  -CA ./ca/RootCA.crt.pem -CAkey ./ca/RootCA.key.pem -CAcreateserial \
  -in ./csr/Logstash.csr.pem -out ./data/logstash/logstash.crt.pem

openssl x509 -req -days 365 \
  -CA ./ca/RootCA.crt.pem -CAkey ./ca/RootCA.key.pem -CAcreateserial \
  -in ./csr/LogstashOSS.csr.pem -out ./data/logstash-oss/logstash.crt.pem

openssl x509 -noout -text -in ./data/logstash/logstash.crt.pem
openssl x509 -noout -text -in ./data/logstash-oss/logstash.crt.pem