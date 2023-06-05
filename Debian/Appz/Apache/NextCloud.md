#### Information Système
```
Debian 11: Bullseye
```

#### Dépôt BookWorm
```
clear;
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list;
sed -i -e 's/bullseye/bookworm/g'     /etc/apt/sources.list;
apt update;
apt upgrade -y;
```

#### Utilitaires
```bash
clear;
apt install -y ca-certificates apt-transport-https software-properties-common curl wget unzip 1>/dev/null;
apt update;
```

#### Installation PHP 8 (Inclus Modules)
```bash
clear;
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list;

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


#### MariaDB
Le mot de passe du compte Root de la base de donnée est contenu dans la variable `PASSWORD_DB`soit par défaut `admin`.
```bash
clear;
PASSWORD_DB=admin
apt install -y mariadb-server 1>/dev/null;
(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "$PASSWORD_DB"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```

#### Apache2
```bash
clear;
apt install -y apache2 1>/dev/null;
```


#### Base de Donée
```
# Connexion à la SQL:
mysql -u root -padmin;

# Purge (Database et User)
DROP DATABASE IF EXISTS website;
DROP USER IF EXISTS 'nextcloud'@'localhost';

# Création de la Base De Donnée
CREATE DATABASE IF NOT EXISTS website;

# Création de l'utilisateur
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'admin';

# Editier les permissions
GRANT ALL PRIVILEGES ON website.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;



# Vérification
mysql -u nextcloud -padmin;

# Afficher les Bases de données:
SHOW DATABASES;

# Afficher les Utilisateurs:
SELECT User FROM mysql.user;

```

#### Téléchargement du site Nextcloud
```bash
wget https://download.nextcloud.com/server/releases/latest.zip -O /tmp/Nextcloud.zip;
unzip /tmp/Nextcloud.zip -d /var/www/html/;
chown -R www-data:www-data /var/www/html/;
```
