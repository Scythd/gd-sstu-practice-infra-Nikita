#!/bin/bash

sudo ln -s /snap/bin/docker /usr/bin/docker

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 176361202031.dkr.ecr.us-east-1.amazonaws.com

docker pull 176361202031.dkr.ecr.us-east-1.amazonaws.com/ecr:latest

docker run -d -p 8080:8080 --name petclinic 176361202031.dkr.ecr.us-east-1.amazonaws.com/ecr:latest