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

# Set filesystem permissions for sites folder and contents
RUN /opt/drupal/web/fix-permissions.sh

# Alternate entrypoint script for debugging container that will keep container running
#ENTRYPOINT ["tail", "-f", "/dev/null"]
