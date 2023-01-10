#!/bin/bash
#updating amazon linux patches
sudo yum update -y
#installing docker engine
sudo amazon-linux-extras install docker -y
#starting docker service
sudo service docker start
#Adding user ec2-user to docker group
sudo usermod -a -G docker ec2-user
#enabling docker service
sudo chkconfig docker on
#downloading docker compose
sudo curl -L https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
#changing the permissions
sudo chmod +x /usr/local/bin/docker-compose

sudo systemctl restart docker
