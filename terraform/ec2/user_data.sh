#!/bin/bash

sudo apt-get update
sudo apt-get install ruby wget -y

cd /home/ubuntu
wget https://aws-codedeploy-eu-central-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

sudo systemctl enable codedeploy-agent
sudo systemctl start codedeploy-agent
