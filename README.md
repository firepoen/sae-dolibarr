# SAE51 - Dolibarr

Projet de mise en place d'un ERP/CRM Dolibarr avec Docker.

L'infrastructure est composée de deux conteneurs :
- Dolibarr
- MariaDB

Le projet permet d'automatiser :
- l'installation avec `install.sh`
- l'import de tiers depuis un fichier CSV avec `import_csv.sh`
- la sauvegarde avec `backup.sh`
- la restauration des données avec `restore.sh`

Dolibarr est accessible sur : http://localhost:8080