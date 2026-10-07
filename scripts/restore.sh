#!/bin/bash

set -e

BACKUP_DIR="./backups"

echo "================================="
echo " Restauration SAE51 - Dolibarr"
echo "================================="

# Recherche des sauvegardes les plus récentes
DB_BACKUP=$(ls -t "$BACKUP_DIR"/dolibarr_db_*.sql 2>/dev/null | head -n 1)
DOC_BACKUP=$(ls -t "$BACKUP_DIR"/dolibarr_documents_*.tar.gz 2>/dev/null | head -n 1)

# Vérification des sauvegardes
if [ -z "$DB_BACKUP" ]; then
    echo "Erreur : aucune sauvegarde MariaDB trouvée."
    exit 1
fi

if [ -z "$DOC_BACKUP" ]; then
    echo "Erreur : aucune sauvegarde des documents trouvée."
    exit 1
fi

echo "Sauvegarde BDD utilisée : $DB_BACKUP"
echo "Sauvegarde documents utilisée : $DOC_BACKUP"

echo ""
echo "Restauration de la base MariaDB..."

cat "$DB_BACKUP" | docker exec -i sae-dolibarr-db \
    mariadb -u dolibarr -pdolibarr dolibarr

echo "Base de données restaurée."

echo ""
echo "Restauration des documents Dolibarr..."

cat "$DOC_BACKUP" | docker exec -i sae-dolibarr-app \
    tar xzf - -C /var/www/documents

echo "Documents restaurés."

echo ""
echo "================================="
echo " Restauration terminée"
echo "================================="