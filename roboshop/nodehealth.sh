#!/bin/bash

################
#Author:sneha
#This is ti check the node health

set -x #debug mode
set -e #exit the script when there is an error
set -o #pipefail

df -h

nproc

free -g