#!/bin/bash
# The Drought Learning Network: dln.swclimatehub.info
# Setup filesystem permissions for drupal to run
#
# Script made by David Rush, davidprush@gmail.com
# Changes the permissions of the Drupal sites directory to secure after isntallation
# Very Important Put this script in the same directory as your site/ directory
# You are free to distribute, change, delete, or whatever the hell you want with this script
# see @https://www.drupal.org/node/244924#comment-6600078 for original script

echo "Start fixing permissions..."

# Save current working directory to variable
DIR=$(pwd)
# Change directory to web folder
cd /opt/drupal/web

# Declare file and folder paths
#SITE="default"
SITE="dln.swclimatehub.info"
SITES="sites"
MSETTINGS="sites/sites.php"
DEFAULT="sites/${SITE}"
SETTINGS="sites/${SITE}/settings.php"

FILES="sites/${SITE}/files"
FHTACCESS="sites/${SITE}/files/.htaccess"

LIBRARIES="sites/${SITE}/libraries"
THEMES="sites/${SITE}/themes"
MODULES="sites/${SITE}/modules"

PRIVATE="sites/${SITE}/private"
PCSHTACCESS="sites/${SITE}/private/config/sync/.htaccess"
PFHTACCESS="sites/${SITE}/private/files/.htaccess"
PTHTACCESS="sites/${SITE}/private/temp/.htaccess"

# Declare binary file paths
CHOWN="/bin/chown"
CHMOD="/bin/chmod"

# Change permissions to secure sites folder and its contents
$CHOWN -R root:root ${SITES}
$CHMOD 755 ${SITES}
$CHOWN :www-data ${SETTINGS}
$CHMOD 440 ${SETTINGS}
$CHMOD 640 ${MSETTINGS}

$CHOWN -R :www-data ${FILES}
$CHMOD -R 775 ${FILES}
$CHMOD 440 ${FHTACCESS}

$CHMOD -R 755 ${LIBRARIES}
$CHMOD -R 755 ${MODULES}
$CHMOD -R 755 ${THEMES}

$CHOWN -R :www-data ${PRIVATE}
$CHMOD -R 770 ${PRIVATE}
$CHMOD 440 ${PCSHTACCESS}
$CHMOD 440 ${PFHTACCESS}
$CHMOD 440 ${PTHTACCESS}

# Change directory to previous state
cd ${DIR}

echo "Done fixing permissions, verify all permisssions are correct!"

# script done