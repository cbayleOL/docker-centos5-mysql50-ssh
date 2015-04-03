# docker-centos5-mysql50-ssh
Docker container with centos5 / mysql 5.0 / ssh
This is very simple container based on standart centos package with a shell access
To act as a master or a slave

It is built from
- tutum-centos5 (See README-ssh.md)
- tutum-docker-mysql where ubuntu:trusty has been replaced with centos:centos5 (See README-mysql.md)

One of the purpose is to enable db upgrade from
mysql 5.0 as a slave
then 
upgrade to 5.1 with docker-centos6-mysql51-ssh
then
upgrade to 5.5 with tutum-docker-mysql/5.5

Work in progress !
