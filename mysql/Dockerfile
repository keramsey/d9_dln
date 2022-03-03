FROM mysql:8.0.28
#FROM mysql:latest

# Update apt to allow installation of system packages
RUN apt-get update \
  && apt-get install apt-file -y

# Install system packages
RUN apt-file update \
  && apt-get install vim -y \
  && apt-get install netcat -y

# Copy database configuration file
COPY ./mysql/my.cnf /etc/mysql/my.cnf

# Add database backup dump file for initial population of database
ADD ./src-dln-mysql/dlnswclimatehub.sql /docker-entrypoint-initdb.d
#ADD ./src-dln-mysql/dlnswclimatehub.sql.gz /docker-entrypoint-initdb.d

# Alternate entrypoint script for debugging container that will keep container running
#ENTRYPOINT ["tail", "-f", "/dev/null"]
