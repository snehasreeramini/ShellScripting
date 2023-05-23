#!/bin/bash

source components/common.sh
COMPONENT=cart

NODEJS
#Print "Install required software" &>>$LOG_FILE
#yum install nodejs make gcc-c++ -y
#StatCheck $?
#
#Print "Add user"&>>$LOG_FILE
#useradd roboshop
#StatCheck $?
#
#Print "Download the content"
#$ curl  -f -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG_FILE
#StatCheck $?
#
#cd /home/roboshop
#
#Print "Extracting archive"
#unzip /tmp/cart.zip && mv cart-main cart && cd cart &>>$LOG_FILE
#
#Print "install npm"
#npm install
#StatCheck $?
#Now, lets set up the service with systemctl.
#
#Print "Update Roboshop Configuration"&>>$LOG_FILE
#mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
#
#
#Print" Starting Cart "
#systemctl daemon-reload && systemctl start cart && systemctl enable cart
#StatCheck $?