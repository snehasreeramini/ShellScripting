#!/bin/bash

USER_ID=$(id -u)
if ["$USER_ID" -ne 0]; then
   echo you should run your script as sudo root user
   exit 1
fi

echo -e "\e[36m Installing Nginx \e[0m"
yum install nginx -y
if [$? -eq 0]; then
  echo  -e "\e[32mSUCCESS\e[0m"
else
  echo "\e[32mFAILURE\e[0m"
  exit 1
fi

#Let's download the HTDOCS content and deploy under the Nginx path.
echo -e "\e[36m Downloading Nginx content \e[0m"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if [$? -eq 0]; then
  echo "\e[32mSUCCESS\e[0m"
else
  echo "\e[32mFAILURE\e[0m"
  exit 1
fi

#Deploy in Nginx Default Location.
echo -e "\e[36m Cleaning Old Nginx Content and extract the downloaded new content \e[0m"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

if [$? -eq 0]; then
  echo "\e[32mSUCCESS\e[0m"
else
  echo "\e[32mFAILURE\e[0m"
  exit 1
fi

#Finally restart the service once to effect the changes.
echo -e "\e[36m Starting Nginx \e[0m"
systemctl restart nginx
systemctl enable nginx

if [$? -eq 0]; then
  echo "\e[32mSUCCESS\e[0m"
else
  echo "\e[32mFAILURE\e[0"
  exit 1
fi