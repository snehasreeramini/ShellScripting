#!/bin/bash

source components/common.sh
COMPONENT=cart

NODEJS
#Print "Install required software" &>>$LOG_FILE
#yum install angularjs make gcc-c++ -y
#StatCheck $?
#
#Print "Add user"&>>$LOG_FILE
#useradd roboshop
#StatCheck $?
#
#Print "Download the content"
#$ curl  -f -s -L -o /tmp/b_cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG_FILE
#StatCheck $?
#
#cd /home/roboshop
#
#Print "Extracting archive"
#unzip /tmp/b_cart.zip && mv b_cart-main b_cart && cd b_cart &>>$LOG_FILE
#
#Print "install npm"
#npm install
#StatCheck $?
#Now, lets set up the service with systemctl.
#
#Print "Update Roboshop Configuration"&>>$LOG_FILE
#mv /home/roboshop/b_cart/systemd.service /etc/systemd/system/b_cart.service
#
#
#Print" Starting Cart "
#systemctl daemon-reload && systemctl start b_cart && systemctl enable b_cart
#StatCheck $?