#!/bin/bash

# Arrête le script si une commande échoue
set -e

# Dossier de sauvegarde et date utilisée dans le nom des fichiers
BACKUP_DIR="./backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

echo "Sauvegarde Dolibarr"

# Création du dossier backups s'il n'existe pas
mkdir -p "$BACKUP_DIR"

echo "Sauvegarde de la base MariaDB..."

# Exporte toute la base Dolibarr dans un fichier SQL
docker exec sae-dolibarr-db mariadb-dump \
    -u dolibarr -pdolibarr dolibarr \
    > "$BACKUP_DIR/dolibarr_db_$DATE.sql"

echo "Base sauvegardée."

# Sauvegarde les documents Dolibarr dans une archive compressée
docker exec sae-dolibarr-app \
    tar czf - -C /var/www/documents . \
    > "$BACKUP_DIR/dolibarr_documents_$DATE.tar.gz"

echo "Documents sauvegardés."

echo "Sauvegarde terminée : $BACKUP_DIR"