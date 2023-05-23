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
## curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
#Load the schema for Services.
#
## cd /tmp
## unzip mysql.zip
## cd mysql-main
# mysql -u root -ppassword <shipping.sql