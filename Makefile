CONTAINER_NAME=centos5-mysql50
PUBKEYS=$(shell cat ~/.ssh/authorized_keys) 
# Adapt to your needs
PATH_IN_HOST=/data/Echange/mysql-rec/
SSH_PORT=2222
MYSQL_PORT=3306

start:
	docker run -p $(SSH_PORT):22 -p $(MYSQL_PORT):3306 --name="$(CONTAINER_NAME)" \
	-v $(PATH_IN_HOST):/var/lib/mysql \
	-e AUTHORIZED_KEYS="$(PUBKEYS)" \
	-d $(CONTAINER_NAME)

build:
	docker build -t $(CONTAINER_NAME) .

rm:
	docker rm -f $(CONTAINER_NAME)
