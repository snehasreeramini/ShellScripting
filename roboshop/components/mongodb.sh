#!/bin/bash

source components/common.sh

Print "Setup YUM Repos"
curl -s -o /etc/yum/repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
StatCheck $?

Print "install Mongodb"
yum install -y mongodb-org &>>$LOG_FILE
StatCheck $?

Print "start mongodb"
systemctl enable mongod &>>$LOG_FILE && systemctl start mongod &>>$LOG_FILE
StatCheck $?

Print "Update Liste IP address" &>>$LOG_FILE
 sed -i -e '127.0.0.1/0.0.0.0'  /etc/mongod.config
StatCheck $?

Print "Start MongodB"
systemctl enable mongod &>>$LOG_FILE && systemctl restart momgod &>>$LOG_FILE

Print "Download schema"
curl -f -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print"Extract schema"
cd /tmp && unzip mongodb.zip &>>$LOG_FILE
StatCheck $?

Print "Load Schema"
cd mongodb-main
for schema in catalogue users ; do
  echo -e "Load $schema Schema"
mongo < ${schema}.js &>>$LOG_FILE
StatCheck $?
done