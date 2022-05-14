FROM drupal:9.3.12-php8.0-apache-bullseye

# Install system packages
#  - MySQL client and zup are needed for drush to export database dumps
RUN apt-get update \
  && apt-get install zip -y \
  && apt-get install wget -y \
  && apt-get install default-mysql-client -y

# Copy script used to update drupal using composer
COPY ./drupal/update-composer.sh /opt/drupal

# Copy script used to update drupal database using drush
COPY ./drupal/update-drush.sh /opt/drupal

# Copy script used to fix drupal filesystem permissions
COPY ./drupal/fix-permissions.sh /opt/drupal/web

# Copy dln.swclimatehub.info site folder contents to sites/default
COPY ./src-dln-site/default/ /opt/drupal/web/sites/default

# Create libraries folder
RUN mkdir /opt/drupal/web/libraries

# Create private folders
RUN mkdir /opt/drupal/private
RUN mkdir /opt/drupal/private/config
RUN mkdir /opt/drupal/private/config/sync
RUN mkdir /opt/drupal/private/files
RUN mkdir /opt/drupal/private/temp

# Copy .htaccess files and private/files folder contents but not configuration or temp files
#COPY .src-dln-drupal-private/ /opt/drupal/private
COPY ./src-dln-private/config/sync/.htaccess /opt/drupal/private/config/sync
COPY ./src-dln-private/temp/.htaccess /opt/drupal/private/temp
COPY ./src-dln-private/files/ /opt/drupal/private/files

# Set filesystem permissions for sites folder and contents
RUN bash /opt/drupal/web/fix-permissions.sh

# Alternate entrypoint script for debugging container that will keep container running
#ENTRYPOINT ["tail", "-f", "/dev/null"]
