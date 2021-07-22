#!/bin/bash

#download it
#sudo curl -o /root/amazon-cloudwatch-agent.deb https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
#install it
#sudo dpkg -i -E /root/amazon-cloudwatch-agent.deb
#admin to agent
#sudo usermod -aG adm cwagent
# agent config
#sudo echo '{
#"agent": {
#"metrics_collection_interval": 5,
#"run_as_user": "cwagent",
#"credentials_path":"/home/cwagent/.aws/credentials"
#},
#"logs": {
#"logs_collected": {
#"files": {
#"collect_list": [
#{
#"file_path": "/var/log/syslog",
#"log_group_name": "ASG_Metrics_Group",
#"log_stream_name": "{hostname}/syslog",
#"timestamp_format" :"%b %d %H:%M:%S"
#}
#]
#}
#}
#}
#}' > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
# start agent
#sudo systemctl enable amazon-cloudwatch-agent.service
#sudo service amazon-cloudwatch-agent start

# pull and run docker

sudo ln -s /snap/bin/docker /usr/bin/docker

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 176361202031.dkr.ecr.us-east-1.amazonaws.com

docker pull 176361202031.dkr.ecr.us-east-1.amazonaws.com/ecr:latest

docker run -d -p 8080:8080 --name petclinic 176361202031.dkr.ecr.us-east-1.amazonaws.com/ecr:latest