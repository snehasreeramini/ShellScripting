#!/bin/bash

source components/common.sh

Print "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
StatCheck $?

#Let's download the HTDOCS content and deploy under the Nginx path.
Print "Downloading Nginx content"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"&>>$LOG_FILE
StatCheck $?

#Deploy in Nginx Default Location.
Print "Cleaning Old Nginx Content and extract the downloaded new content "&>>LOG_FILE
rm -rf /usr/share/nginx/html/*
StatCheck $?

cd /usr/share/nginx/html

Print "Extracting archive"&>>$LOG_FILE
unzip /tmp/frontend.zip && mv frontend-main/* .&& mv static/* .
#logical and tells all commands to be executed
#local or tells to execute any one of the command
StatCheck $?

rm -rf frontend-master README.md

Print "Update Roboshop Configuration"&>>${LOG_FILE}
mv localhost.conf /etc/nginx/default.d/roboshop.conf
for component in catalogue user cart ; do
  echo -e "Updating $component configuration"
sed -i -e '${component}/s/localhost/${component}.roboshopinternal/' #SEARCH FOR CATATLOGUE AND SUBSTITUTE CATALOGUE.ROBOSHOPINTERNAL AT CATALOGUE PLACE IN /ETC LOCATION.
StatCheck $?
done
#Finally restart the service once to effect the changes.

Print" Starting Nginx "
systemctl restart nginx &>>${LOG_FILE} && systemctl enable nginx &>>${LOG_FILE}
StatCheck $?


