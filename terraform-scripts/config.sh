#! /bin/bash
sudo mv /etc/init.d/tomcat.sh /etc/init.d/tomcat
sudo chmod +x /etc/init.d/tomcat
service tomcat start
