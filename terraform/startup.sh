#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y
sudo apt install docker.io docker docker-clean containerd docker-registry
sudo groupadd docker
sudo usermod -aG docker $USER
