# Docker commands to setup MySQL

```
alias docker_mysql_container='docker run --detach --name mysql_v8 --publish 3306:3306 --env="MYSQL_ROOT_PASSWORD=root" --volume=/Users/prraj/codebase/docker_files/mysql_v8/config/conf.d:/etc/mysql/conf.d --volume=/Users/prraj/codebase/docker_files/mysql_v8/data:/var/lib/mysql mysql:8'

alias docker_mysql_container_start='docker run --name mysql_v8 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password@123 -d mysql:8'
```

# Docker commands to setup Zookeeper and Kafka

```
docker network create app-tier --driver bridge

alias docker_zookeeper_container='docker run --detach --name zookeeper_v3.8 --network app-tier --publish 2181:2181 --env="ALLOW_ANONYMOUS_LOGIN=yes" --volume=/Users/prraj/codebase/docker_files/zookeeper_v3.8:/bitnami/zookeeper bitnami/zookeeper:3.8'

alias docker_kafka_container='docker run --detach --name kafka_v3.3 --network app-tier --publish 9092:9092 --env="KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper_v3.8:2181" --env="ALLOW_PLAINTEXT_LISTENER=yes" --volume=/Users/prraj/codebase/docker_files/kafka_v3.3:/bitnami/kafka bitnami/kafka:3.3'

alias docker_zookeeper_container_start='docker run --name zookeeper_v3.8 --network app-tier -p 2181:2181 -e ALLOW_ANONYMOUS_LOGIN=yes -d bitnami/zookeeper:3.8'

alias docker_kafka_container_start='docker run --name zookeeper_v3.8 --network app-tier  -p 9092:9092 -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper_v3.8:2181 -e ALLOW_PLAINTEXT_LISTENER=yes -d bitnami/kafka:3.3'
```
