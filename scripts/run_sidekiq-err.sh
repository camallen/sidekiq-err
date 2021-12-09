#!/bin/bash

# report status on startup so folks think something is happening
echo
sleep 2
sidekiq-err --report all
echo
echo

# loop and report status continually
while :
do
	sleep 10
  echo
  sidekiq-err --report all
  echo
  echo '---- Hit CTRL+C TO STOP ----'
  echo
  echo
done
