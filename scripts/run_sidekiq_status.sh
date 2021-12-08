#!/bin/bash

# report status on startup so folks think something is happening
echo
sleep 2
sidekiq_status all
echo
echo

# loop and report status continually
while :
do
	sleep 10
  echo
  sidekiq_status all
  echo
  echo '---- Hit CTRL+C TO STOP ----'
  echo
  echo
done
