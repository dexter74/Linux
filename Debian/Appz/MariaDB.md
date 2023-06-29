------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation de MariaDB </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Installation
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
