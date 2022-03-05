#!/bin/bash
# The Drought Learning Network: dln.swclimatehub.info
# Install drush, drupal superfish module and
# update drupal database using composer
#
# Exit script if any command fails (non-zero value)
set -e
# Clear composer cache
composer clearcache
# Install drush
composer require drush/drush:^10 --ignore-platform-req=ext-gd
# Install superfish (libraries)
composer require drupal/superfish:^1.4
# Clear composer cache
composer clearcache
# Save current working directory to variable
DIR=$(pwd)

# Set Drupal website filesystem permissions
#cd /opt/drupal/web
#bash ./fix-permissions.sh

# Change directory to site folder
cd /opt/drupal/web/sites/dln.swclimatehub.info
# Clear drush cache
drush cc drush
# Uninstall nice_menus theme (not supported in Drupal 9)
drush -y pm:uninstall nice_menus
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
# Export Drupal database to compressed file (--gzip appends .gz to file extension)
# which updates database script used to populate mysql container
drush -y sql-dump --gzip --result-file=/var/mysql/backups/latest/dlnswclimatehub.sql --extra-dump=--no-tablespaces
# Clear drush cache
drush cc drush
# Change directory to previous state
cd ${DIR}
#echo ${dir}
# Act as passthrough for subsequent command arguments that may be supplied runtime
set "@0"