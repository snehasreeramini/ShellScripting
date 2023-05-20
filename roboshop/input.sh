#!/bin/bash

read -p "Enter your name: " name
echo "your name is $name"

Special variables
#$0-$n,$*,$#,$@
echo script name=$0
echo first argument= $1
echo All arguments=$*
echo Number of arguments=$#