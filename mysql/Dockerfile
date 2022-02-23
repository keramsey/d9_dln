FROM mysql:8.0.28
#FROM mysql:latest

RUN apt-get update \
  && apt-get install apt-file -y

RUN apt-file update \
  && apt-get install vim -y \
  && apt-get install netcat -y

COPY ./mysql/my.cnf /etc/mysql/my.cnf

ADD ./dln-mysql-backups/dlnswclimatehub.sql /docker-entrypoint-initdb.d

# ENTRYPOINT /var/mysql/backups/entrypoint.sh users ${MUSR} ${MPW} ${MDB}