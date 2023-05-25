#!/bin/bash

source components/common.sh

COMPONENT=payments

PYTHON

Print"Install python"
Install Python 3 &>>$LOG_FILE
StatCheck $?
# yum install python36 gcc python3-devel -y

Print"Create a user"
useradd roboshop &>>$LOG_FILE
StatCheck $?


print"Download the repo"
cd /home/roboshop
curl -f -L -s -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip"&>>$LOG_FILE
StatCheck $?

Print"Extract the archive"
unzip /tmp/payment.zip && mv payment-main payment

Print"Install the dependencies"
cd /home/roboshop/payment
pip3 install -r requirements.txt &>>$LOG_FILE
StatCheck $?

Note: Above command may fail with permission denied, So run as root user

Update the roboshop user and group id in payment.ini file.

Setup the service

Print"Update robosho config"
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service &>>$LOG_FILE
StatCheck $?

Print"start payments"
systemctl daemon-reload && systemctl enable payment && systemctl start payment &>>$LOG_FILE
StatCheck $?