#!bin/bash
yum update -y
yum install postgresql-server -y
/usr/bin/postgresql-setup --initdb