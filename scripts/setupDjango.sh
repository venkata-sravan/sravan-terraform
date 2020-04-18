#!/bin/bash

sudo apt update -y
sudo apt install unzip -y
sudo apt install python3.8 -y
sudo apt install virtualenv -y
virtualenv -p /usr/bin/python3.8 django
cp /tmp/activate.sh ~/activate.sh
chmod +x activate.sh
bash activate.sh
