#!/bin/sh
# Exit script if any command fails (non-zero value)
set -e
# Install drush
composer require --dev drush/drush:^10
# Install bibcite module prerequisite packages
composer require -W academicpuma/citeproc-php:~1.0 adci/full-name-parser:^0.2.4 technosophos/libris:~2.0 audiolabs/bibtexparser:dev-master caseyamcl/php-marc21:~1.0
# Install admin_toolbar module
composer require -W drupal/admin_toolbar:^3.1 drupal/state_machine:^1.6
# Install bibcite modules
composer require -W drupal/bibcite:^2.0@beta
# Update drupal database and rebuild cache from site folder
cd web/sites/dln.swclimatehub.info
# Update drupal database
drush updb
# Clear drush cache
drush cc drush
# Rebuild drupal cache
drush cr
# Act as passthrough for subsequent command arguments that may be supplied runtime
set "@0"