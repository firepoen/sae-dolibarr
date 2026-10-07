#!/bin/bash

# Arrête le script si une commande échoue
set -e

echo "Installation de Dolibarr"

# Vérifie que Docker est installé
if ! command -v docker >/dev/null 2>&1; then
    echo "Erreur : Docker n'est pas installé."
    exit 1
fi

# Vérifie que Docker Compose est disponible
if ! docker compose version >/dev/null 2>&1; then
    echo "Erreur : Docker Compose n'est pas disponible."
    exit 1
fi

# Lance Dolibarr et MariaDB
echo "Démarrage des conteneurs..."
docker compose -f docker/docker-compose.yml up -d

# Attend que MariaDB soit prête
echo "Attente de MariaDB..."

until docker exec sae-dolibarr-db mariadb-admin ping \
    -u dolibarr -pdolibarr --silent >/dev/null 2>&1
do
    sleep 2
done

echo "MariaDB est prête."

# Affiche les conteneurs du projet
docker ps --filter "name=sae-dolibarr"

echo "Installation terminée."
echo "Dolibarr : http://localhost:8080"