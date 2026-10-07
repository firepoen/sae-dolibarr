#!/bin/bash

# Fichier CSV à importer
CSV_FILE="./data/tiers.csv"

# Permet de gérer les apostrophes dans les données
sql_escape() {
    printf "%s" "$1" | sed "s/'/''/g"
}

echo "Import des tiers"

# Vérifie que le fichier CSV existe
if [ ! -f "$CSV_FILE" ]; then
    echo "Erreur : fichier $CSV_FILE introuvable."
    exit 1
fi

# Lit le CSV en ignorant la première ligne (les titres)
tail -n +2 "$CSV_FILE" | while IFS=',' read -r nom statut adresse cp ville pays telephone email client fournisseur tva
do

    # Prépare les textes avant de les envoyer à la base
    nom=$(sql_escape "$nom")
    adresse=$(sql_escape "$adresse")
    ville=$(sql_escape "$ville")
    telephone=$(sql_escape "$telephone")
    email=$(sql_escape "$email")

    # Vérifie si l'adresse email existe déjà dans Dolibarr
    existe=$(docker exec sae-dolibarr-db mariadb \
        -N -s -u dolibarr -pdolibarr dolibarr \
        -e "SELECT COUNT(*) FROM llx_societe WHERE email='$email';")

    # Si le tiers existe déjà, on passe au suivant
    if [ "$existe" -gt 0 ]; then
        echo "Déjà présent : $nom"
        continue
    fi

    # Ajoute le nouveau tiers dans la base Dolibarr
    docker exec sae-dolibarr-db mariadb \
        -u dolibarr -pdolibarr dolibarr \
        -e "INSERT INTO llx_societe
        (nom, status, address, zip, town, fk_pays, phone, email, client, fournisseur, tva_assuj)
        VALUES
        ('$nom', '$statut', '$adresse', '$cp', '$ville', 1, '$telephone', '$email', '$client', '$fournisseur', '$tva');"

    echo "Importé : $nom"

done

echo "Import terminé"