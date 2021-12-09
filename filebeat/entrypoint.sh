#!/bin/bash

nohup filebeat -e -strict.perms=false &

while true ; do
  LOG="`date +"%Y-%m-%d %H:%M:%S"` INFO Went to home"
  echo "${LOG}" >> server.log
  sleep 1
done