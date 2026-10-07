#!/bin/bash

# Arrête le script si une commande échoue
set -e

# Dossier contenant les sauvegardes
BACKUP_DIR="./backups"

echo "Restauration de Dolibarr"

# Récupère les sauvegardes les plus récentes
DB_BACKUP=$(ls -t "$BACKUP_DIR"/dolibarr_db_*.sql 2>/dev/null | head -n 1)
DOC_BACKUP=$(ls -t "$BACKUP_DIR"/dolibarr_documents_*.tar.gz 2>/dev/null | head -n 1)

# Vérifie que les sauvegardes existent
if [ -z "$DB_BACKUP" ]; then
    echo "Erreur : aucune sauvegarde MariaDB trouvée."
    exit 1
fi

if [ -z "$DOC_BACKUP" ]; then
    echo "Erreur : aucune sauvegarde des documents trouvée."
    exit 1
fi

echo "Restauration de la base MariaDB..."

# Envoie la sauvegarde SQL dans MariaDB
cat "$DB_BACKUP" | docker exec -i sae-dolibarr-db \
    mariadb -u dolibarr -pdolibarr dolibarr

echo "Base restaurée."

# Restaure les documents dans Dolibarr
cat "$DOC_BACKUP" | docker exec -i sae-dolibarr-app \
    tar xzf - -C /var/www/documents

echo "Documents restaurés."
echo "Restauration terminée."