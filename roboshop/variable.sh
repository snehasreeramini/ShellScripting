#!/bin/bash

a=100
b=devops

echo ${a}times
echo $b Training

DATE=2023-05-19
echo Today data is $DATE

DATE=$(date +%f)
echo Today date is $DATE
echo Time is $(date +%t)

x=10
y=20
ADD=$($x+$y)
echo add= $ADD