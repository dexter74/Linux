----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Base de donnée
```
Host:
 - 127.0.0.1
 - localhost

Administrateur:
 - Identifiant  : root
 - Mot de passe : admin

Utilisateur:
 - Identifiant    : GLPI
 - Mot de passe   : GLPI
 - Base de Donnée : GLPI
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Se connecter en Root
```
su -;
```

### Dépôt
Commenter la ligne `cdrom` du fichier `/etc/apt/sources.list`.

```bash
sed -i -e "s/^deb cdrom/#deb cdrom/g" /etc/apt/sources.list;
```

### Mettre à jour le Système
```bash
apt update;
apt upgrade -y;
```

### Installation de Sudo
```bash
apt install -y sudo;
```

#### Mauvaise Pratique
Cette pratique est uniquement pour l'apprentissage ! (Diminue la sécurité !)
```bash
# Récupére le nom d'utilisateur de l'ID 1000
UTILISATEUR=$(id 1000 | cut -d "(" -f 2 | cut -d ")" -f 1)

# Sudoers son utilisateur (No Password)
echo "$UTILISATEUR ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/admin;

# Accès SSH par le compte root
sed -i -e "s/\#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;
systemctl restart ssh;
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Installation des paquets de base
```bash
apt install -y apache2;
apt install -y libapache2-mod-php;
apt install -y mariadb-server;
apt install -y php;
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Sécuriser la Base De Donnée
La commande echo permet d'envoyer des messages à la commande, et chaque echo correspond à une question poser. (`echo "" est une réponse sans valeur`) 
```bash
PASSWORD_DB=admin
(echo ""; echo "y" ; echo "y"; echo "$PASSWORD_DB"; echo "$PASSWORD_DB"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```

### Connexion à la Base de Donnée
```bash
mysql -u root -padmin;
```

### Purge Database et User
```bash
DROP DATABASE IF EXISTS GLPI;
DROP USER IF EXISTS 'GLPI'@'localhost';
```

### Création de la BDD
```bash
CREATE DATABASE IF NOT EXISTS GLPI;
```

### Création de l'utilisateur
```bash
CREATE USER 'GLPI'@'localhost' IDENTIFIED BY 'admin';
```

### Edition des permissions
```bash
GRANT ALL PRIVILEGES ON GLPI.* TO 'GLPI'@'localhost';
```

### Fuseau Horaire
```
# mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -padmin -u root mysql
GRANT SELECT ON `mysql`.`time_zone_name` TO 'GLPI'@'localhost';
FLUSH PRIVILEGES;
```

### Déconnexion MYSQL
```bash
quit;
```


A ce stade, on à crée la base de donnée, l'utilisateur avec son mot de passe. et pour terminer les permissions sur la base de donnée sur GLPI.  (L'utilisateur GLPI à tout droit sur la BDD GLPI)

<r />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Choisir la Version de GLPI </p>

### GLPI 9.5.X
```bash
FILE="https://github.com/glpi-project/glpi/releases/download/9.5.12/glpi-9.5.12.tgz"
wget "$FILE"  -O /tmp/glpi-9.5.12.tgz;
rm -r /var/www/html/glpi 2>/dev/null;
tar -xvf /tmp/glpi-9.5.12.tgz -C /var/www/html;
```

### GLPI 10.0.6
```bash
FILE="https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz"
wget "$FILE" -O /tmp/glpi-10.0.6.tgz;
rm -r /var/www/html/glpi 2>/dev/null;
tar -xvf  /tmp/glpi-10.0.6.tgz -C /var/www/html;
```

### Permission
L'utilisateur du service Apache2 est `www-data` et appartient au groupe `www-data` et le dossier `www` est son dossier de travail. Il est indispensable qu'il est le contrôle de tout les fichiers.
```bash
chown -R www-data:www-data /var/www/html/;
```

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Installation des extensions
Un Site Web nécessite des extensions selon les fonctions ou le langage utilisé, on n'installe les extensions que si il est nécessaire.

Un module php à comme préfixe `php-` suivis du nom de l'extension.


#### GLPI 9.5.X
![image](https://user-images.githubusercontent.com/35907/236466165-1fd9544b-9ca5-4bef-b147-7b7c533136c5.png)

La version 9.5.X requiert: 
```
- apcu
- bz2
- curl
- gd
- intl
- ldap
- mbstring
- mysqli
- simplexml
- xmlrpc
- zip
```

#### Exemple de module
```bash
apt install -y php-apcu apcupsd;
apt install -y php-bz2;
apt install -y php-curl;
apt install -y php-gd;
apt install -y php-intl;
apt install -y php-ldap;
apt install -y php-mbstring;
apt install -y php-mysqli;
apt install -y php-simplexml;
apt install -y php-xmlrpc;
apt install -y php-zip;
```


### Relancer le Service Apache2
Apache charge PHP et ses modules et lorsqu'on installe des modules, il faut relancer le service.
```bash
systemctl restart apache2;
```
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Vérification (Prérequis, Sécurité)
```bash
/var/www/html/glpi/bin/console glpi:system:check_requirements;
```

![image](https://user-images.githubusercontent.com/35907/236469772-68412a28-12dc-4a62-b6b2-35f503c053a3.png)


### Installation du site
La commande permet de déclencher l'installation du Site sans passer par l'installation Web, puis il faut taper `yes` pour valider l'installtion. (Connexion à la BDD, création de la Base de donnée)
```bash
/var/www/html/glpi/bin/console db:install \
--reconfigure \
--default-language=fr_FR \
--db-host=localhost \
--db-port=3306 \
--db-name=GLPI \
--db-user=GLPI \
--db-password=admin --force;
```


#### Sécurité
Le fichier install.php doit être renommé ou Supprimé
```bash
mv /var/www/html/glpi/install/install.php     /var/www/html/glpi/install/install.php.old;
rm /var/www/html/glpi/install/install.php.old;
```

#### Gestionnaire de Base De Donnée (phpmyadmin)
```bash
apt upgrade -y php-tcpdf php-twig unzip;
wget "https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip" -O  /tmp/phpMyAdmin.zip;
unzip /tmp/phpMyAdmin.zip -d /var/www/html;
mv /var/www/html/phpMyAdmin-5.2.1-all-languages /var/www/html/phpmyadmin;
```



#### Divers Commande [ICI](https://glpi-install.readthedocs.io/fr/develop/command-line.html#cdline-install)
```
/var/www/html/glpi/bin/console glpi:maintenance:enable;
/var/www/html/glpi/bin/console glpi:maintenance:disable;

/var/www/html/glpi/bin/console glpi:migration:timestamps;
/var/www/html/glpi/bin/console db:update -f;
```


