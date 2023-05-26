#!/bin/bash

source/components=common.sh

COMPONENT=dispatch

Print"Install GOLANG"
yum install golang -yum

APP_SETUP

Print"go commands"
cd dispatch &>>${LOG_FILE} && go mod init dispatch &>>${LOG_FILE} &&go get &>>${LOG_FILE} && go build &>>${LOG_FILE}
StatCheck $?

SERVICE_SETUP



