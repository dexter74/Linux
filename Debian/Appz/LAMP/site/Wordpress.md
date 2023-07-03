-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation de Wordpress </p>

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Installation de Wordpress
#### X. Téléchargement du Site
```
wget https://fr.wordpress.org/latest-fr_FR.zip -O /tmp/latest-fr_FR.zip;
unzip /tmp/latest-fr_FR.zip -d /var/www/html;
```

#### X. Permission
```
chown -R www-data:www-data /var/www/html;
```

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Base De Donnée
#### X. Création de La Base De Donnée
Le nom de la Base de donnée est `wordpressdb`, l'identifiant est `wordpress` et le mot de passe est `mypassword`.
```sql
clear;

# Purge (Database et User)
mysql -u root -padmin -e "DROP DATABASE IF EXISTS wordpressdb; DROP USER IF EXISTS 'wordpress'@'localhost';"

# Création de la Base De Donnée
mysql -u root -padmin -e "CREATE DATABASE IF NOT EXISTS wordpressdb;"

# Création de l'utilisateur
mysql -u root -padmin -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'mypassword';"

# Editer les permissions
mysql -u root -padmin -e "GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wordpress'@'localhost';FLUSH PRIVILEGES;"

# Vérification
mysql -u root -padmin -e "SELECT User FROM mysql.user;"
mysql -u root -padmin -e "SHOW DATABASES;"
```

#### C. Vérification de l'accès à la Base De Donnée
```sql
mysql -u wordpress -pmypassword -e "SHOW DATABASES;"
```
<br />
