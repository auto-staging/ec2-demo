#!/bin/bash

sudo chown -R ubuntu:ubuntu /opt/auto-staging-ec2-demo/
sudo systemctl start auto-staging-ec2-demo
sudo systemctl enable auto-staging-ec2-demo
