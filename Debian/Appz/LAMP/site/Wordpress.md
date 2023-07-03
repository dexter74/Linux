-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation de Wordpress </p>

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Installation de Wordpress
#### X. Téléchargement du Site
```
wget https://fr.wordpress.org/latest-fr_FR.zip -O /tmp/latest-fr_FR.zip;
unzip /tmp/latest-fr_FR.zip -d /var/www/html;
rm /tmp/latest-fr_FR.zip
```

#### X. Rétablir les Permissions
```
chown -R www-data:www-data /var/www/html/wordpress;
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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Sécurisation de Wordpress
#### A. Création du htaccess
Autoriser uniquement le réseau `192.168.0.0/24` à accéder au site Wordpress.
```bash
echo "Order Deny,Allow
Allow from 192.168.0.0/255.255.255.0
Deny from all" > /var/www/html/wordpress/.htaccess
```

#### B. Activation du htaccess
```
# Sauvegarde du fichier de base d'Apache
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.old;
sed -i -e 's/AllowOverride None/AllowOverride ALL/g' /etc/apache2/apache2.conf;
```
#### C. htaccess pour le dossier Wordpress
```
sed -i -e 's/Directory \/var\/www\//Directory \/var\/www\/wordpress\//g' /etc/apache2/apache2.conf;
```

#### D. Relance du service Apache2
```
systemctl restart apache2;
```

#### E. Restauration de la configuration Apache
```
cat /etc/apache2/apache2.conf.old > /etc/apache2/apache2.conf;
systemctl restart apache2;
```
