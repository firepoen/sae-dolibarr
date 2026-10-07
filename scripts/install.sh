#!/bin/bash

set -e

echo "================================="
echo " Installation SAE51 - Dolibarr"
echo "================================="

# Vérification de Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "Erreur : Docker n'est pas installé."
    exit 1
fi

echo "Docker détecté."

# Vérification de Docker Compose
if ! docker compose version >/dev/null 2>&1; then
    echo "Erreur : Docker Compose n'est pas disponible."
    exit 1
fi

echo "Docker Compose détecté."

echo ""
echo "Démarrage de Dolibarr et MariaDB..."

docker compose -f docker/docker-compose.yml up -d

echo ""
echo "Attente du démarrage de MariaDB..."

until docker exec sae-dolibarr-db mariadb-admin ping \
    -u dolibarr -pdolibarr --silent >/dev/null 2>&1
do
    echo "MariaDB n'est pas encore prêt..."
    sleep 2
done

echo "MariaDB est prêt."

echo "Conteneurs démarrés."

echo ""
echo "Vérification des conteneurs..."
docker ps --filter "name=sae-dolibarr"

echo ""
echo "================================="
echo " Installation terminée"
echo " Dolibarr : http://localhost:8080"
echo "================================="