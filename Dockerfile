FROM centos:centos5

MAINTAINER Christian Bayle <christian.bayle@orange.com>

RUN yum -y install epel-release \
    && yum -y install mysql-server openssh-server epel-release pwgen && \
    rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

## SSH ##
# Add SSH scripts
ADD set_root_pw.sh /set_root_pw.sh
ADD run_ssh.sh /run_ssh.sh

# SSH Exposed ENV
ENV AUTHORIZED_KEYS **None**

## MYSQL ##
# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Remove syslog configuration
#RUN rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf

# Add MySQL configuration
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# Add MySQL scripts
ADD import_sql.sh /import_sql.sh
ADD run_mysql.sh /run_mysql.sh

# MYSQL Exposed ENV
ENV MYSQL_USER admin
ENV MYSQL_PASS **Random**

# Replication ENV
ENV REPLICATION_MASTER **False**
ENV REPLICATION_SLAVE **False**
ENV REPLICATION_USER replica
ENV REPLICATION_PASS replica

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

# Add start script
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22 3306

CMD ["/run.sh"]
