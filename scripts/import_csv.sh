#!/bin/bash

CSV_FILE="./data/tiers.csv"

sql_escape() {
    printf "%s" "$1" | sed "s/'/''/g"
}

echo "=== Import automatique des tiers ==="

if [ ! -f "$CSV_FILE" ]; then
    echo "Erreur : fichier $CSV_FILE introuvable."
    exit 1
fi

echo "Fichier CSV détecté : $CSV_FILE"
echo "Import en cours..."

tail -n +2 "$CSV_FILE" | while IFS=',' read -r nom statut adresse cp ville pays telephone email client fournisseur tva
do

    nom=$(sql_escape "$nom")
    adresse=$(sql_escape "$adresse")
    ville=$(sql_escape "$ville")
    telephone=$(sql_escape "$telephone")
    email=$(sql_escape "$email")

        existe=$(docker exec sae-dolibarr-db mariadb \
        -N -s -u dolibarr -pdolibarr dolibarr \
        -e "SELECT COUNT(*) FROM llx_societe WHERE email='$email';")

    if [ "$existe" -gt 0 ]; then
        echo "Ignoré (déjà présent) : $nom"
        continue
    fi


    docker exec sae-dolibarr-db mariadb \
        -u dolibarr -pdolibarr dolibarr \
        -e "INSERT INTO llx_societe
        (nom, status, address, zip, town, fk_pays, phone, email, client, fournisseur, tva_assuj)
        VALUES
        ('$nom', '$statut', '$adresse', '$cp', '$ville', 1, '$telephone', '$email', '$client', '$fournisseur', '$tva');"

    echo "Importé : $nom"
done

echo "=== Import terminé ==="