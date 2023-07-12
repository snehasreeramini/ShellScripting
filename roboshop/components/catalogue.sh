#!/bin/bash

source components/common.sh
COMPONENT=catalogue

NODEJS
#Print "Configure Yum Repos"
#curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>${LOG_FILE}
#StatCheck $?
#
#Print "Install required software" &>>${LOG_FILE}
#yum install angularjs make gcc-c++ -y
#StatCheck $?
#
#Print "Add Application user"
#id ${APP_USER} &>>${LOG_FILE}
#if[ $? -ne 0 ]; then
#    useradd ${APP_USER} &>>${LOG_FILE}
#    StatCheck $?
# fi
#
#Print "Download App Component"
#curl  -f -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE
#StatCheck $?
#
#Print"Cleanup old content"
#rm -rf /home/${APP_USER}/catalogue &>>${LOG_FILE}
#StatCheck $?
#
#Print "Extract App content"
#cd /home/${APP_USER} && unzip -o /tmp/catalogue.zip &>>${LOG_FILE}
#StatCheck $?
#
#Print "Install App Dependencies"
#cd /home/${APP_USER}/catalogue&>>${LOG_FILE} && npm install &>>${LOG_FILE}
#StatCheck $?
#
#NOTE: We need to update the IP address of MONGODB Server in systemd.service file
#Now, lets set up the service with systemctl.
#
#
#Print "Fix App User permissions"
#chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
#StatCheck $?
#
#Print "Setup SystemD file"
#sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'
#/home/${APP_USER}/catalogue/systemd.service &>>$LOG_FILE && mv /home/${APP_USER}/catalogue/systemd.service
#/etc/systemd/system/catalogue.service &>>${LOG_FILE}
#StatCheck $?
#
#Print"start catalogue"
#systemctl daemon-reload &>>${LOG_FILE} && systemctl start catalogue &>>${LOG_FILE} && systemctl enable catalogue &>>${LOG_FILE}
#StatCheck $?