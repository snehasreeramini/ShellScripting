#!/bin/bash

source components/common.sh

Print "Configure Yum repos"
curl -f -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
StatCheck $?

Print "Install Mysql"
yum install mysql-community-server -y &>>${LOG_FILE}
StatCheck $?

Print"Start MySQL service"
systemctl enable mysqld &>>${LOG_FILE} && systemctl start mysqld &>>${LOG_FILE}
StatCheck $?

echo 'show databases' | mysql -uroot -pRoboshop@1 &>>${LOG_FILE}
if [$? -ne 0 ]; then
  print "change Default Root Password"
  echo "SET PASSWORD FOR 'root'@'localhost' =  PASSWORD('Roboshop@1');" >/tmp/rootpass.sql
 DEFAULT_ROOT_PASSWORD=$(grep 'tempprary password' /var/log/mysqld.log | awk '{print $NF}')
mysql --connect-expired-password -uroot -p"${DEFAULT_ROOT_PASSWORD}" </tmp/rootpass.sql &>>${LOG_FILE}
StatCheck $?
fi

echo show plugins | mysql -uroot -pRoboshop@1 2>>${LOG_FILE} | grep validate_password
if [ $? -eq 0]; then
  Print "Uninstall password Validate Plugin"
  echo 'Uninstall plugin validate password;' >/tmp/pass-validate.sql
  mysql --connect-expired-password -uroot -pRoboshop@1 </tmp/pass-validate.sql &>>${LOG_FILE}
  StatCheck $?
  fi

Print "Download Schema"
curl -f -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"&>>${LOG_FILE}
StatCheck $?

Print "Extract schema"
cd /tmp && unzip -o mysql.zip &>>${LOG_FILE}
StatCheck $?

Print "Load Schema"
cd mysql-main && mysql -u root -pRoboshop@1 <shipping.sql &>>${LOG_FILE}
StatCheck $?



#Setup MySQL Repo
## echo '[mysql57-community]
#name=MySQL 5.7 Community Server
#baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
#enabled=1
#gpgcheck=0' > /etc/yum.repos.d/mysql.repo
#
#Install MySQL
## yum remove mariadb-libs -y
#
#Start MySQL.
#
#Now a default root password will be generated and given in the log file.
## grep temp /var/log/mysqld.log
#
#Next, We need to change the default root password in order to start using the database service.
## mysql_secure_installation
#
#You can check the new password working or not using the following command.
#
## mysql -u root -p
#
#Run the following SQL commands to remove the password policy.
#> uninstall plugin validate_password;
#> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
#Setup Needed for Application.
#As per the architecture diagram, MySQL is needed by
#
#Shipping Service
#So we need to load that schema into the database, So those applications will detect them and run accordingly.
#
#To download schema, Use the following command
#
##
#Load the schema for Services.
#
## cd /tmp
## unzip mysql.zip
## cd mysql-main
# mysql -u root -ppassword <shipping.sql