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

Print "Installing Nginx"
yum install nginx -y
StatCheck $?

#Let's download the HTDOCS content and deploy under the Nginx path.
Print "Downloading Nginx content"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
StatCheck $?

#Deploy in Nginx Default Location.
Print "Cleaning Old Nginx Content and extract the downloaded new content "
rm -rf /usr/share/nginx/html/*
StatCheck $?

cd /usr/share/nginx/html

Print "Extracting archive"
unzip /tmp/frontend.zip && mv frontend-main/* .&& mv static/* .
#logical and tells all commands to be executed
#local or tells to execute any one of the command
StatCheck $?

rm -rf frontend-master README.md
Print "Update Roboshop Configuration"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
StatCheck $?
#Finally restart the service once to effect the changes.

Print" Starting Nginx "
systemctl restart nginx
StatCheck $?
systemctl enable nginx

