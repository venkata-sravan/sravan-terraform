#!/bin/bash

sudo yum update -y
sudo yum remove -y java
wget https://www.apache.org/dist/tomcat/tomcat-9/v9.0.31/bin/apache-tomcat-9.0.31.tar.gz
tar -zxvf apache-tomcat-9.0.31.tar.gz
sudo yum install -y java-1.8.0-openjdk.x86_64
sudo cp /tmp/tomcat.sh /etc/init.d/tomcat.sh
sudo cp /tmp/tomcat-users.xml /home/ec2-user/apache-tomcat-9.0.31/conf/tomcat-users.xml 
sudo yum install python36 -y
sudo ln -sf /usr/bin/python3 /usr/bin/python
sudo ln -sf usr/bin/pip-3.6 /usr/bin/pip
sudo pip-3.6 install credstash
