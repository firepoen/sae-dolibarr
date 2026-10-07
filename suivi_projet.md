# Suivi du projet SAE51 - Dolibarr

## 22/09/2026 - Mise en place du projet

- Lecture du sujet et définition de l'organisation du projet.
- Création du dépôt GitHub `sae-dolibarr`.
- Création du README, du suivi de projet et du fichier de sources.
- Installation et vérification de Docker Desktop.
- Création du fichier `docker-compose.yml`.
- Choix d'une architecture avec deux conteneurs : Dolibarr et MariaDB.
- Déploiement des deux conteneurs.
- Premier accès à l'interface web de Dolibarr.

## 28/09/2026 - Configuration de Dolibarr

- Configuration initiale de Dolibarr.
- Vérification de la connexion avec MariaDB.
- Création et configuration du compte administrateur.
- Découverte de l'interface et des différents modules.
- Activation du module Tiers.
- Activation du module d'import de données.
- Création d'un premier client de test.
- Création d'un utilisateur standard.
- Vérification de la persistance des données avec Docker.

## 30/09/2026 - Import des données

- Création du fichier `data/tiers.csv`.
- Ajout de plusieurs entreprises fictives dans le CSV.
- Test de l'import manuel avec l'outil intégré à Dolibarr.
- Association des colonnes du CSV avec les champs Dolibarr.
- Simulation de l'import.
- Import des Tiers dans Dolibarr.
- Vérification des données importées.
- Étude de la structure de la base de données Dolibarr et de la table `llx_societe`.

## 05/10/2026 - Automatisation de l'import

- Création du script `import_csv.sh`.
- Automatisation de l'ajout des Tiers dans MariaDB.
- Test du script avec le fichier `tiers.csv`.
- Ajout d'une vérification par adresse email pour éviter les doublons.
- Test du système anti-doublons.
- Gestion des apostrophes présentes dans les données.
- Correction des problèmes d'encodage UTF-8.
- Vérification des données directement dans MariaDB.

## 06/10/2026 - Installation et sauvegarde automatisées

- Création et amélioration du script `install.sh`.
- Vérification automatique de la présence de Docker.
- Vérification de Docker Compose.
- Automatisation du lancement des conteneurs.
- Ajout de l'attente du démarrage de MariaDB.
- Création du script `backup.sh`.
- Sauvegarde automatique de la base MariaDB.
- Sauvegarde des documents Dolibarr.
- Vérification des fichiers de sauvegarde générés.
- Création du script `restore.sh`.

## 07/10/2026 - PRA et finalisation

- Test du script de restauration.
- Restauration de la base de données MariaDB.
- Restauration des documents Dolibarr.
- Test du PRA avec création d'une donnée après une sauvegarde.
- Restauration de la sauvegarde et vérification du retour à l'état précédent.
- Test de l'installation et de la persistance des données.
- Vérification du fonctionnement des quatre scripts :
  - `install.sh`
  - `import_csv.sh`
  - `backup.sh`
  - `restore.sh`
- Vérification de l'arborescence du projet.
- Mise à jour du README.
- Mise à jour du suivi de projet.
- Vérification des sources.
- Test final permettant de repartir d'une installation propre et de restaurer les données.
- Vérification finale du dépôt et envoi des derniers fichiers sur GitHub.

## Bilan final

Le projet permet de déployer Dolibarr et MariaDB avec Docker, d'importer automatiquement des Tiers depuis un fichier CSV et de sauvegarder puis restaurer les données.

L'installation, l'import, la sauvegarde et la restauration sont automatisés 