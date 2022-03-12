#!/bin/bash
# The Drought Learning Network: dln.swclimatehub.info
# Install drush, drupal superfish module and
# update drupal database using composer
#
# Exit script if any command fails (non-zero value)
set -e
# Save current working directory to variable
DIR=$(pwd)
# Clear composer cache
composer clearcache
# Install drush
composer require drush/drush:^10 --ignore-platform-req=ext-gd
# Install superfish (libraries)
composer require drupal/superfish:^1.4
# Clear composer cache
composer clearcache

# Set Drupal website filesystem permissions
bash /opt/drupal/web/fix-permissions.sh

# Patch drupal8_zymphonies_theme.theme file (version 2.02)
cd /opt/drupal/web//themes/contrib/drupal8_zymphonies_theme
wget https://www.drupal.org/files/issues/2020-11-27/3185149-syntax-error-3.patch
patch -p1 < 3185149-syntax-error-3.patch

# Change directory to site folder
cd /opt/drupal/web/sites/default

# Clear drush cache
drush cr

# Uninstall nice_menus theme (not supported in Drupal 9)
#drush -y pm:uninstall nice_menus

# Uninstall dust_bartik subtheme (not supported in Drupal 9)
#drush -y pm:uninstall dust_bartik

# Install drupal8_zymphonies_theme theme (base theme)
drush -y theme-enable drupal8_zymphonies_theme
# Install claro (experimental) admin theme
drush -y theme-enable claro

# Set default admin theme to claro theme
drush -y config:set system.theme admin claro
# Enable contrib modules
drush -y en serialization bibcite bibcite_entity bibcite_export bibcite_import bibcite_bibtex bibcite_endnote bibcite_marc bibcite_ris

# Put website in maintenance mode
drush state:set system.maintenance_mode 1

# Export Drupal database to compressed file (--gzip appends .gz to file extension)
echo "Backing up database..."
drush -y sql-dump --gzip --result-file=/var/mysql/backups/prior/dlnswclimatehub.sql --extra-dump=--no-tablespaces
echo "...completed!"
# Backup web folder
echo "Backing up files..."
tar -czf /var/mysql/backups/prior/dlnswclimatehub_web.tar.gz /opt/drupal/web
tar -czf /var/mysql/backups/latest/dlnswclimatehub_private.tar.gz /opt/drupal/private
echo "...completed!"

# Rebuild drupal cache
drush cr
# Update drupal database
drush -y updb
# Install dln_drupal8_zymphonies_theme theme (subtheme) after updating drupal database
drush -y theme-enable dln_drupal8_zymphonies_theme
# Set default theme to dln_drupal8_zymphonies_theme theme (subtheme)
drush -y config-set system.theme default dln_drupal8_zymphonies_theme

# Update drupal database (after setting default theme, otherwise white screen on Appearance admin page)
drush -y updb
# Rebuild drupal cache
drush cr

# Export configuration
drush -y config:export
# Remove duplicate config yml files, then import config to delete from database
#find . -type f -regex '.*_[2|3|4]\.yml' -exec bash rm -f {} \;
# Import configuration
#drush -y config:import
# Export Drupal database to compressed file (--gzip appends .gz to file extension)
echo "Backing up database..."
drush -y sql-dump --gzip --result-file=/var/mysql/backups/latest/dlnswclimatehub.sql --extra-dump=--no-tablespaces
echo "...completed!"
# Backup web folder
echo "Backing up files..."
tar -czf /var/mysql/backups/latest/dlnswclimatehub_web.tar.gz /opt/drupal/web
tar -czf /var/mysql/backups/latest/dlnswclimatehub_private.tar.gz /opt/drupal/private
echo "...completed!"
# Take website out of maintenance mode
drush state:set system.maintenance_mode 0

# Rebuild drupal cache
drush cr
# Clear drush cache
drush cc drush
# Change directory to previous state
cd ${DIR}
#echo ${dir}
# Act as passthrough for subsequent command arguments that may be supplied runtime
set "@0"