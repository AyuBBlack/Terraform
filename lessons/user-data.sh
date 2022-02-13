#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://16.170.216.54/latest/meta-data/local-ipv4`
echo "<h2>Web Server with IP: $myip</h2><br> by Terraform" > /var/www/index.html
sudo service httpd start
chkconfig httpd on
