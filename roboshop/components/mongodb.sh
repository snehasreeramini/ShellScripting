#!/bin/bash

StatCheck() {
if [$1 -eq 0]; then
  echo  -e "\e[32mSUCCESS\e[0m"
else
  echo "\e[31mFAILURE\e[0m"
  exit 2
fi
}
Print(){
  echo -e "\e[36m $1 \e[0m"
}
USER_ID=$(id -u)
if ["$USER_ID" -ne 0]; then
   echo you should run your script as sudo root user
   exit 1
fi

LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

Print "Setup YUM Repos"
curl -s -o /etc/yum/repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
StatCheck $?
Print "install Mongodb"
yum install -y mongodb-org &>>$LOG_FILE
StatCheck $?

Print "start mongodb"
systemctl enable mongod &>>$LOG_FILE && systemctl start mongod &>>$LOG_FILE
StatCheck $?

Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file
Config file: /etc/mongod.conf

then restart the service

# systemctl restart mongod

# curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js
