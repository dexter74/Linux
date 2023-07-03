-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'>.: Installation de Wordpress :.</p>


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Création de La Base De Donnée
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
### X. Installation de Wordpress
#### X. Téléchargement du Site
```bash
wget https://fr.wordpress.org/latest-fr_FR.zip -O /tmp/latest-fr_FR.zip;
unzip /tmp/latest-fr_FR.zip -d /var/www/html;
rm /tmp/latest-fr_FR.zip
```

#### X. Rétablir les Permissions
```bash
chown -R www-data:www-data /var/www/html/wordpress;
```

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Méthode 2: Plugin Wordpress (A voir)
Les plugins suivants force l'authentification lorsqu'on souhaite consulter Wordpress. Il existe une possibilité d'ajouter des IP ayant pas besoin de s'authentifier.
#### X. Restricted Site Access
```
Adresses IP sans restriction: 192.168.0.1/24
```
 
#### X. Intranet and Extranet with O365 Login
```
```

<br />

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Méthode X: Sécurisation de Wordpress par filtra IP (Expérimental)

### X. Sauvegarde du fichier de base d'Apache
```bash
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.old;
```

#### X. Restauration de la configuration Apache
```bash
cat /etc/apache2/apache2.conf.old > /etc/apache2/apache2.conf;
systemctl restart apache2;
```

#### X. Activer le htacess dans Wordpress
```
# Remplacer la ligne 172 (none en all)
sed -i '172s/None/all/' /etc/apache2/apache2.conf;

# Insérer des lignes à partir de ligne 175
echo "<Directory /var/www/wordpress/>
AllowOverride all
</Directory>" >> /etc/apache2/apache2.conf; systemctl restart apache2;
```

#### X. Création du htaccess
Autoriser uniquement le réseau `192.168.0.0/24` à accéder au site Wordpress.
```bash
echo "order deny,allow
deny from all
allow from 192.168.0.0/255.255.255.0
php_value upload_max_filesize 256M" > /var/www/html/wordpress/.htaccess;
```

Note: Sa autoriser le pare-feu et donc les Machines des Zones LAN.

#### X. Rétablir les Permissions
```bash
chown -R www-data:www-data /var/www/html/wordpress;
```


<br />



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Liste de plugins:
```
All-In-One Intranet
bbPress
BuddyPress
Active Directory Integration / LDAP Integration : Permet l'authentification dans une active directory, requiert le paquet php-ldap puis relancer apache2.
WP Basic Authentication   :
WP htaccess Editor        : Editeur dans Wordpress du HTACCESS
```
