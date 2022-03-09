FROM drupal:9.3.7-php8.0-apache-bullseye

# Install system packages
#  - MySQL client is needed for drush to export database dumps
RUN apt-get update \
  && apt-get install zip -y \
  && apt-get install default-mysql-client -y

# Copy script used to update drupal using composer
COPY ./drupal/update-composer.sh /opt/drupal

# Copy script used to update drupal database using drush
COPY ./drupal/update-drush.sh /opt/drupal

# Copy script used to fix drupal filesystem permissions
COPY ./drupal/fix-permissions.sh /opt/drupal/web

# Copy dln.swclimatehub.info site folder contents to sites/default
COPY ./src-dln-drupal-sites/default/ /opt/drupal/web/sites/default

# Delete private folder under site folder which will be moved outside of docroot later
RUN rm -rf /opt/drupal/web/default/private

# Create libraries folder
RUN mkdir /opt/drupal/web/libraries

# Create private folders
RUN mkdir /opt/drupal/private
RUN mkdir /opt/drupal/private/config
RUN mkdir /opt/drupal/private/config/sync
RUN mkdir /opt/drupal/private/files
RUN mkdir /opt/drupal/private/temp

# Copy .htaccess files and private/files folder contents
COPY ./src-dln-drupal-sites/default/private/config/sync/.htaccess /opt/drupal/private/config/sync
COPY ./src-dln-drupal-sites/default/private/temp/.htaccess /opt/drupal/private/temp
COPY ./src-dln-drupal-sites/default/private/files/ /opt/drupal/private/files

# Set filesystem permissions for sites folder and contents
RUN /opt/drupal/web/fix-permissions.sh

# Alternate entrypoint script for debugging container that will keep container running
#ENTRYPOINT ["tail", "-f", "/dev/null"]
