------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de NextCloud sur Debian 11 </p>

<br /> 

![image](https://github.com/dexter74/Linux/assets/35907/a0c5e9cf-1fbe-4f49-a47c-b25de1b949c5)

------------------------------------------------------------------------------------------------------------------------------------
### I. Installation des Pre-requis
#### A. Dépôt BookWorm
Les `paquets requis` pour `NextCloud` requiert le dépôt `BookWorm` car les modules PHP pour nextcloud sont absent de Bullseye.
```
clear;

# Commenté la ligne CDROM
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list;

# Remplacer bullseye par bookworm
sed -i -e 's/bullseye/bookworm/g'     /etc/apt/sources.list;

# Mise à jour liste des paquets
apt update;

# Upgrade des paquets
apt upgrade -y;
```

#### B. Utilitaires
Utilitaires indispensables sur la distribution Linux.
```bash
clear;
apt install -y ca-certificates apt-transport-https software-properties-common curl wget unzip 1>/dev/null;
apt update;
```
<br />

------------------------------------------------------------------------------------------------------------------------------------
### II. PHP 8 (Optionnel)
#### A. Mise en place du Dépôt PHP
```bash
clear;
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list;
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
<br />

------------------------------------------------------------------------------------------------------------------------------------
### IV. Base De Donnée
#### A. Création de La Base De Donnée
Le nom de la Base de donnée est `website`, l'identifiant est `nextcloud` et le mot de passe est `mypassword`.
```sql
# Connexion à la SQL:
mysql -u root -padmin;

# Purge (Database et User)
DROP DATABASE IF EXISTS website;
DROP USER IF EXISTS 'nextcloud'@'localhost';

# Création de la Base De Donnée
CREATE DATABASE IF NOT EXISTS website;

# Création de l'utilisateur
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'mypassword';

# Editier les permissions
GRANT ALL PRIVILEGES ON website.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;

# Quitter la connexion
exit;
```

#### C. Vérification de l'accès à la Base De Donnée
```sql
# Connexion à la SQL (Compte de service)
mysql -u nextcloud -pmypassword;

# Afficher les Bases de données
SHOW DATABASES;

# Afficher les Utilisateurs:
SELECT User FROM mysql.user;

# Quitter la connexion
exit;
```
<br />

------------------------------------------------------------------------------------------------------------------------------------
### V. Nextcloud
#### A. Téléchargement de Nextcloud
```bash
wget https://download.nextcloud.com/server/releases/latest.zip -O /tmp/Nextcloud.zip;
unzip /tmp/Nextcloud.zip -d /var/www/html;
```

#### B. Permissions (Apache)
Apache2 qui est le service Web utilise le compte de service `www-data`, il faut remettre les bonnes permissions. (Page Blanche sinon) 
```
chown -R www-data:www-data /var/www/html;
```

#### C. Relance du service Apache2
```
systemctl restart apache2;
```

#### D. Début de l'installation
```
http://<IP du serveur>/nextcloud
# Utilisateur de la Base de donnée  : nextcloud
# Mot de passe de la Base de donnée : mypassword
# Nom de la Base de donnée          : website
# Hôte de la Base de donnée         : localhost
```

Si à la fin l'URL est KO, revenir juste en arrière et c'est terminé.

