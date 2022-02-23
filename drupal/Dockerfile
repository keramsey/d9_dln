FROM drupal:9.3.6-php8.0-apache-bullseye

RUN apt-get update \
  && apt-get install apt-file -y

RUN apt-file update \
  && apt-get install zip -y \
  && apt install git -y

# Copy script needed by dln-init-drupal container
COPY drupal/init-drupal.sh /opt/drupal

#ENTRYPOINT [ "sh", "/init-drupal.sh" ]
#ADD ./drupal/init-drupal.sh /docker-entrypoint-initdb.d
#CMD ["tail","-f", "/dev/null"]
