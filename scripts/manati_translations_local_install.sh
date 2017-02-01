#!/usr/bin/env bash
if [ -f ./.vendor/bin/drush ] ; then mv ./.vendor ./vendor ; fi
DRUSH="./vendor/bin/drush"
SITE_ALIAS="@manati_translations.manati-translations.dev"
SITE_UUID="2208af61-80e2-49fa-b048-ea0e29b46af0"
$DRUSH $SITE_ALIAS cc drush
echo "Installing..."
if [ -f ./files/config/sync/core.extension.yml ] ; then $DRUSH $SITE_ALIAS si manati_translations --account-pass=admin -y ; else $DRUSH $SITE_ALIAS si manati_translations --account-pass=admin -y ; fi
echo "Set site uuid..."
$DRUSH $SITE_ALIAS config-set "system.site" uuid "$SITE_UUID" -y
echo "Importing config..."
if [ -f ./files/config/sync/core.extension.yml ] ; then $DRUSH $SITE_ALIAS cim -y ; fi
echo "Cleaning cache..."
$DRUSH $SITE_ALIAS cr
mv ./vendor ./.vendor
