#!/bin/bash
# The Drought Learning Network: dln.swclimatehub.info
# Install drupal modules and prerequisite packages using composer
#
# Exit script if any command fails (non-zero value)
set -e
# Clear composer cache
composer clearcache
# Install drush
composer require drush/drush:^10 --ignore-platform-req=ext-gd --no-update -q
# Install bibcite module prerequisites
composer require -w academicpuma/citeproc-php:~1.0 adci/full-name-parser:^0.2.4 technosophos/libris:~2.0 audiolabs/bibtexparser:^1.0 caseyamcl/php-marc21:~1.0 --ignore-platform-req=ext-gd --no-update -q
# Install bibcite module
composer require -w drupal/bibcite:^2.0@beta drupal/bibcite_entity:^2.0@beta drupal/bibcite_migrate:^2.0@beta --ignore-platform-req=ext-gd --no-update -q
# Install bibcite_migrate module --- IF drupal/drupal:^9
#composer require -W drupal/bibcite_migrate:^2.0@beta --ignore-platform-req=ext-gd --no-update -q
# Install contrib modules
composer require -w drupal/admin_toolbar:^3.1 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/ckeditor_responsive_plugin:^2.0 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/download_count:^2.0 --ignore-platform-req=ext-gd --no-update -q
composer require -W drupal/drupal8_zymphonies_theme:^2.0 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/easy_breadcrumb:^2.0 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/editor_advanced_link:^2.0 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/entity:^1.2 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/entity_reference_revisions:^1.9 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/file_entity:^2.0@beta --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/google_analytics:^3.1 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/google_tag:^1.4 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/inline_entity_form:^1.0@RC --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/jquery_ui:^1.4 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/menu_block:^1.7 --ignore-platform-req=ext-gd --no-update -q
#composer require -W drupal/nice_menus:^1.0@beta --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/profile:^1.3 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/state_machine:^1.6 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/superfish:^1.4 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/taxonomy_manager:^2.0 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/tb_megamenu:^1.6 --ignore-platform-req=ext-gd --no-update -q
composer require -w drupal/token:^1.10 --ignore-platform-req=ext-gd --no-update -q
#composer require -w drupal/webform:^6.0 --ignore-platform-req=ext-gd --no-update -q
composer update --ignore-platform-req=ext-gd
# Clear composer cache
composer clearcache
# Allow plugins to silence trust composer messages
# see @https://www.drupal.org/project/drupal/issues/3255749#comment-14348050
composer config allow-plugins true -n
set "@0"