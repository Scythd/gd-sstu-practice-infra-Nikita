#!/bin/bash

sudo ln -s /snap/bin/docker /usr/bin/docker

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 176361202031.dkr.ecr.us-east-1.amazonaws.com

docker pull 176361202031.dkr.ecr.us-east-1.amazonaws.com/ecr:latest

docker run -d -p 8080:8080 --name petclinic 176361202031.dkr.ecr.us-east-1.amazonaws.com/ecr:latest



sudo curl -o /root/amazon-cloudwatch-agent.deb https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E /root/amazon-cloudwatch-agent.deb
sudo usermod -aG adm cwagent
sudo echo '{
        "agent": {
                "metrics_collection_interval": 60,
                "run_as_user": "cwagent"
        },
        "metrics": {
                "append_dimensions": {
                        "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
                        "ImageId": "${aws:ImageId}",
                        "InstanceId": "${aws:InstanceId}",
                        "InstanceType": "${aws:InstanceType}"
                },
                "metrics_collected": {
                    "cpu": {
                            "measurement": [
                                    "cpu_usage_idle",
                                    "cpu_usage_iowait",
                                    "cpu_usage_user",
                                    "cpu_usage_system"
                            ],
                            "metrics_collection_interval": 60,
                            "resources": [
                                    "*"
                            ],
                            "totalcpu": false
                    },
                    "disk": {
                            "measurement": [
                                    "used_percent",
                                    "inodes_free"
                            ],
                            "metrics_collection_interval": 60,
                            "resources": [
                                    "*"
                            ]
                    },
                    "diskio": {
                            "measurement": [
                                    "io_time"
                            ],
                            "metrics_collection_interval": 60,
                            "resources": [
                                    "*"
                            ]
                    },
                    "mem": {
                            "measurement": [
                                    "mem_used_percent"
                            ],
                            "metrics_collection_interval": 60
                    }
                }
        }
}' > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo systemctl enable amazon-cloudwatch-agent.service
sudo service amazon-cloudwatch-agent start