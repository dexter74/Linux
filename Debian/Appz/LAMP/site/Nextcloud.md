------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de NextCloud sur Debian 11 (PHP 8 Requis)</p>

<br /> 

![image](https://github.com/dexter74/Linux/assets/35907/a0c5e9cf-1fbe-4f49-a47c-b25de1b949c5)

------------------------------------------------------------------------------------------------------------------------------------
### I. Installation des Pre-requis
#### A. Utilitaires
Utilitaires indispensables sur la distribution Linux.
```bash
clear;
apt install -y ca-certificates apt-transport-https software-properties-common curl wget unzip 1>/dev/null;
apt update;
```
<br />

------------------------------------------------------------------------------------------------------------------------------------
### II. PHP 8
#### A. Mise en place du Dépôt PHP
```bash
clear;
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list;
apt update;
```

#### B. Installation des Packages PHP
```bash
clear;
apt install php                 1>/dev/null;
apt install libapache2-mod-php  1>/dev/null;
apt install -y php-curl         1>/dev/null;
apt install -y php-gd           1>/dev/null;
apt install -y php-mbstring     1>/dev/null;
apt install -y php-mysql        1>/dev/null;
apt install -y php-xml          1>/dev/null;
apt install -y php-zip          1>/dev/null;


# php -m;
# apt search php | grep -i XXX;
```

#### C. Switch PHP 7 vers PHP 8.
```
clear;
/usr/sbin/a2dismod php*;
/usr/sbin/a2enmod php8.2;
```


#### D. Relance d'Apache
```bash
clear;
systemctl restart apache2;
```

<br />

------------------------------------------------------------------------------------------------------------------------------------
### IV. Base De Donnée
#### A. Création de La Base De Donnée
Le nom de la Base de donnée est `website`, l'identifiant est `nextcloud` et le mot de passe est `mypassword`.
```sql
clear;

# Purge (Database et User)
mysql -u root -padmin -e "DROP DATABASE IF EXISTS website; DROP USER IF EXISTS 'nextcloud'@'localhost';"

# Création de la Base De Donnée
mysql -u root -padmin -e "CREATE DATABASE IF NOT EXISTS website;"

# Création de l'utilisateur
mysql -u root -padmin -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'mypassword';"

# Editer les permissions
mysql -u root -padmin -e "GRANT ALL PRIVILEGES ON website.* TO 'nextcloud'@'localhost';FLUSH PRIVILEGES;"

# Vérification
mysql -u root -padmin -e "SELECT User FROM mysql.user;"
mysql -u root -padmin -e "SHOW DATABASES;"
```

#### C. Vérification de l'accès à la Base De Donnée
```sql
mysql -u nextcloud -pmypassword -e "SHOW DATABASES;"
```
<br />

------------------------------------------------------------------------------------------------------------------------------------
### V. Nextcloud
#### A. Téléchargement de Nextcloud
```bash
clear;
wget https://download.nextcloud.com/server/releases/latest.zip -O /tmp/Nextcloud.zip;
unzip /tmp/Nextcloud.zip -d /var/www/html;
```

#### B. Permissions (Apache)
Apache2 qui est le service Web utilise le compte de service `www-data`, il faut remettre les bonnes permissions. (Page Blanche sinon) 
```
clear;
chown -R www-data:www-data /var/www/html;
```

#### C. Début de l'installation
```
# Accéder à l'URL de NextCloud      : http://<IP du serveur>/nextcloud
# Utilisateur de la Base de donnée  : nextcloud
# Mot de passe de la Base de donnée : mypassword
# Nom de la Base de donnée          : website
# Hôte de la Base de donnée         : localhost
```

Si à la fin l'URL est KO, revenir juste en arrière et c'est terminé.

