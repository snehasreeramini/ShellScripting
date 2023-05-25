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
  echo -e "\n-----------------$1----------------"
  &>>$LOG_FILE
  echo -e "\e[36m $1 \e[0m"
}
USER_ID=$(id -u)
if ["$USER_ID" -ne 0]; then
   echo you should run your script as sudo root user
   exit 1
fi

LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

APP_USER=roboshop

APP_SETUP() {
  id ${APP_USER} &>>${LOG_FILE}
  if[ $? -ne 0 ]; then
    Print "Add Application user"
        useradd ${APP_USER} &>>${LOG_FILE}
        StatCheck $?
     fi
     Print "Download App Component"
     curl  -f -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE
     StatCheck $?

     Print"Cleanup old content"
     rm -rf /home/${APP_USER}/${COMPONENT} &>>${LOG_FILE}
     StatCheck $?

     Print "Extract App content"
     cd /home/${APP_USER} && unzip -o /tmp/${COMPONENT}.zip &>>${LOG_FILE}
     StatCheck $?
}

SERVICE_SETUP(){
  Print "Fix App User permissions"
  chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
  StatCheck $?

  Print"Setup Systemd file"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshopinternal/' \
       -e 's/REDIS_ENDPOINT/redis.roboshopinternal' \
       -e  's/MONGO_ENDPOINT/mongodb.roboshopinternal' \
       -e  's/CATALOGUE_ENDPOINT/catalogue.roboshopinternal'\
       -e 's/CARTENDPOINT/cart.roboshop.internal/' \
       -e 's/DBHOST/mysql.roboshop.internal' \
  /home/roboshop/${COMPONENT}/systemd.service &>>${LOG_FILE} && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systems/system/${COMPONENT}.service &>>$LOG_FILE
  StatCheck $?

  Print"restart ${COMPONENT} service"
  Systemctl daemon reload &>>${LOG_FILE} && Systemctl restart ${COMPONENT} &>>${LOG_FILE} && systemctl enable ${COMPONENT} &>>${LOG_FILE}
  }


NODEJS() {
Print "Configure Yum Repos"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>${LOG_FILE}
StatCheck $?

Print "Install required software" &>>${LOG_FILE}
yum install nodejs make gcc-c++ -y
StatCheck $?


APP_SETUP

Print "Install App Dependencies"
cd /home/${APP_USER}/${COMPONENT}&>>${LOG_FILE} && npm install &>>${LOG_FILE}
StatCheck $?

SERVICE_SETUP
}


MAVEN(){
Print"Install maven"
yum install maven -y &>>${LOG_FILE}
StatCheck $?

#CREATE USER
APP_SETUP

Print"Maven packaging"
 cd /home/${APP_USER}/$(COMPONENT) && mvn clean package &>>${LOG_FILE}
 $ mv target/shipping-1.0.jar shipping.jar &>>${LOG_FILE}
 StatCheck $?

SERVICE_SETUP
}