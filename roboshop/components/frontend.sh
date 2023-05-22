#!/bin/bash

StatCheck() {
if [$1 -eq 0]; then
  echo  -e "\e[32mSUCCESS\e[0m"
else
  echo "\e[31mFAILURE\e[0m"
  exit 2
fi
}
USER_ID=$(id -u)
if ["$USER_ID" -ne 0]; then
   echo you should run your script as sudo root user
   exit 1
fi

echo -e "\e[36m Installing Nginx \e[0m"
yum install nginx -y
StatCheck $?

#Let's download the HTDOCS content and deploy under the Nginx path.
echo -e "\e[36m Downloading Nginx content \e[0m"
curl -f -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
StatCheck $?

#Deploy in Nginx Default Location.
echo -e "\e[36m Cleaning Old Nginx Content and extract the downloaded new content \e[0m"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
StatCheck $?
#Finally restart the service once to effect the changes.

echo -e "\e[36m Starting Nginx \e[0m"
systemctl restart nginx
StatCheck $?
systemctl enable nginx

