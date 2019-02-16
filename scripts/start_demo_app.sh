#!/bin/bash

sudo chown -R ubuntu:ubuntu /opt/rocket-service/
sudo systemctl start demo-app
sudo systemctl enable demo-app
