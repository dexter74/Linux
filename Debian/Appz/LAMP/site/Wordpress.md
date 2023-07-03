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
### X. Méthode 1: Sécurisation de Wordpress par filtra IP
#### X. Création du htaccess
Autoriser uniquement le réseau `192.168.0.0/24` à accéder au site Wordpress.
```bash
echo "Order Deny,Allow
Allow from 192.168.0.0/255.255.255.0
Deny from all" > /var/www/html/wordpress/.htaccess
```

### X. Sauvegarde du fichier de base d'Apache
```bash
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.old;
```

#### X. Restauration de la configuration Apache
```bash
cat /etc/apache2/apache2.conf.old > /etc/apache2/apache2.conf;
systemctl restart apache2;
```

#### X. Activation du htaccess
```bash
sed -i -e 's/AllowOverride None/AllowOverride ALL/g' /etc/apache2/apache2.conf;
```

#### X. htaccess pour le dossier Wordpress
```bash
sed -i -e 's/Directory \/var\/www\//Directory \/var\/www\/html\/wordpress\//g' /etc/apache2/apache2.conf;
```

#### X. Relance du service Apache2
```bash
systemctl restart apache2;
```
<br />


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Méthode 2: Plugin Wordpress (A voir)
Les plugins suivants force l'authentification lorsqu'on souhaite consulter Wordpress. Il existe une possibilité d'ajouter des IP ayant pas besoin de s'authentifier
#### X. Restricted Site Access
```
Adresses IP sans restriction: 192.168.0.0/24
```
 
#### X. Intranet and Extranet with O365 Login
```
```

<br />

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### X. Liste de plugins:
```
All-In-One Intranet
bbPress
BuddyPress
```
