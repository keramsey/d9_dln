Drought Learning Network website migration project

This project requires a /src folder containing source:
  1. Drupal 8 libraries, modules, themes and sites folders
  2. MySQL dump file
for the Drought Learning Network website being migrated to
Drupal 9 using Docker containers.

The /src folder is not located in GitHub.

General instructions to update containers:
  1. Update Drupal module
    a. Edit update_drush.sh to require correct module or theme version or to add a new module or theme requirement
    b. In Power Shell terminal:
      cd <d9_dln project folder>
      docker-compose down
      docker-compose build --no-cache
      docker-compose up
    c. Wait for dln-composer to finish updating ( returns exit code 0 )
    d. In another Power Shell terminal:
      cd <d9_dln project folder>
      docker ps
      docker exec -it <dln-drupal ID> bash
    e. Run script to update Drupal database:
      ./update-drush.sh
    f. Login to website and check Updates Available report to verify modules update was performed

  2. Update Drupal core
    a. Edit Dockerfile drupal image version number
    b. In Power Shell terminal:
      cd <d9_dln project folder>
      docker-compose down
      docker volume ls
      docker volume rm <dln-docker ID>
      docker volume rm <dln-docker-data ID>
      docker-compose build --no-cache
      docker-compose up
    c. Wait for dln-composer to finish updating ( returns exit code 0 )
    d. In another Power Shell terminal:
      cd <d9_dln project folder>
      docker ps
      docker exec -it <dln-drupal ID> bash
    e. Run script to update Drupal database:
      ./update-drush.sh
    f. Login to website and check Updates Available report to verify Drupal core update was performed

  3. Update MySQL server
    a. Edit docker-compose.yml mysql image version number
    b. In Power Shell terminal:
      cd <d9_dln project folder>
      docker-compose down
      docker volume ls
      docker volume rm <dln-mysql ID>
      docker-compose build --no-cache
      docker-compose up
    c. Wait for dln-composer to finish updating ( returns exit code 0 )
    d. In another Power Shell terminal:
      cd <d9_dln project folder>
      docker ps
      docker exec -it <dln-drupal ID> bash
    e. Run script to update Drupal database:
      ./update-drush.sh
    f. Login to dln-phpmyadmin to verify mysql update was performed
