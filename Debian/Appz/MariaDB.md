------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation de MariaDB </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Installation
Répondre à toutes les questions par Y sauf à "Disallow root login remotely".
```bash
clear;
PASS_ROOT_SQL=admin
apt install -y mariadb-server 1>/dev/null;
(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "$PASS_ROOT_SQL"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```

## II. Autoriser l'authentification mysql_native_password
Permettra à PHPMYADMIN d'accèder à la base de donnée depuis le compte root.
```bash
clear;
mysql -u root -padmin -e "ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');"
```

## III. Gestion de la Base de Donnée
Création d'une Base de donnée `SITE`, puis un compte de service. (Identifiant: `USER` et mot de passe `password`)
```sql
clear;

# Suppression de la BDD et USER
mysql -u root -padmin -e "DROP DATABASE IF EXISTS SITE;DROP USER IF EXISTS 'USER'@'localhost';"

# Création de la BDD
mysql -u root -padmin -e "CREATE DATABASE IF NOT EXISTS SITE;"

# Création de l'utilisateur
mysql -u root -padmin -e "CREATE USER 'USER'@'localhost' IDENTIFIED BY 'password';"

# Permission de la BDD pour le compte
mysql -u root -padmin -e "GRANT ALL PRIVILEGES ON SITE.* TO 'USER'@'localhost';"

# Permettre l'authentification pour GLPI
mysql -u root -padmin -e "ALTER USER USER@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('password');"
```


## IV. Vérification
```sql
clear;
# DBB et SQL :
mysql -u root -padmin -e "SELECT User FROM mysql.user; SHOW DATABASES;"

# Liste des SQL gérer par le compte USER:
mysql -u USER -ppassword -e "SHOW DATABASES;"
```
