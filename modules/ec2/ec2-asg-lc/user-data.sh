#!/bin/bash

yum update -y && yum install httpd -y && service httpd start && chkconfig httpd on && echo "welcome to 1" >> /var/www/html/index.html