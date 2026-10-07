#!/bin/bash

set -e

BACKUP_DIR="./backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

echo "================================="
echo " Sauvegarde SAE51 - Dolibarr"
echo "================================="

# Création du dossier de sauvegarde
mkdir -p "$BACKUP_DIR"

echo ""
echo "Sauvegarde de la base MariaDB..."

docker exec sae-dolibarr-db mariadb-dump \
    -u dolibarr -pdolibarr dolibarr \
    > "$BACKUP_DIR/dolibarr_db_$DATE.sql"

echo "Base de données sauvegardée."

echo ""
echo "Sauvegarde des documents Dolibarr..."

docker exec sae-dolibarr-app \
    tar czf - -C /var/www/documents . \
    > "$BACKUP_DIR/dolibarr_documents_$DATE.tar.gz"

echo "Documents sauvegardés."

echo ""
echo "================================="
echo " Sauvegarde terminée"
echo " Dossier : $BACKUP_DIR"
echo "================================="