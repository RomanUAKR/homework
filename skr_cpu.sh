#!/bin/bash

distribution=$(lsb_release -si)

if [ "$distribution" != "Ubuntu" ]; then
  echo "Error: This script is for Ubuntu."
  exit 1
fi


sar -u 1 1 | tail -n 1 > cpu-usage.log
