#!/bin/bash

source components/common.sh

COMPONENT=rabbitmq






Print"Configure YUM repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${LOG_FILE}
StatCheck $?

Print"Install Erlang and Rabbit MQ"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm  rabbitmq-server -y &>>${LOG_FILE}
StatCheck $?

Print"Start RabbitMQ Services"
systemctl enable rabbitmq-server &>>${LOG_FILE} && systemctl start rabbitmq-server &>>${LOG_FILE}

RabbitMQ comes with a default username / password as guest/guest. But this user cannot be used to connect. Hence we need to create one user for the application.



//rabbitmqctl gives all options

rabbitmq list users | grep roboshop &>>${LOG_FILE}
if [$? -ne 0 ]; then
  Print "Create Application user"
  rabbitmqctl add_user roboshop roboshop123 &>>${LOG_FILE}
  StatCheck $?
  fi

Print"Configure application user"
rabbitmqctl set_user_tags roboshop administrator ${LOG_FILE} && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"${LOG_FILE}
StatCheck $?