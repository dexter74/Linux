--------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

--------------------------------------------------------------------------------------------------------------------------------------------
## I. Préparation Environnement
#### A. Télécharger GLPI
```bash
clear
VERSION=10.0.7
wget https://github.com/glpi-project/glpi/releases/download/$VERSION/glpi-$VERSION.tgz -O /tmp/glpi.tgz 2>/dev/null;
```

#### B. Extraire GLPI
```bash
tar -xf /tmp/glpi.tgz  -C /var/www/html;
```

#### C. Permission
```bash
chown -R www-data:www-data /var/www/html;
```

#### D. Modules PHP
Les modules sont pas tous compatibles PHP 8.
```bash
# Indispensable:
apt install -y php-curl php-gd php-intl php-mysqli php-simplexml 1>/dev/null;

# Optionnel:
apt install -y php-bz2 php-ldap php-mbstring php-symfony-polyfill-ctype php-zip 1>/dev/null;
```

#### E. Relance du service Apache
```
systemctl restart apache2;
```

#### F. Vérification (Prérequis, Sécurité)
```bash
/var/www/html/glpi/bin/console glpi:system:check_requirements;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
## II. Base De Donnée
#### A. Purge Database et User
```bash
mysql -u root -padmin -e "DROP DATABASE IF EXISTS GLPI;DROP USER IF EXISTS 'GLPI'@'localhost';"
```

#### C. Création de la BDD
La base de donnée se nomme `GLPI`
```bash
mysql -u root -padmin -e "CREATE DATABASE IF NOT EXISTS GLPI;"
```

#### D. Création de l'utilisateur
L'identifiant est `GLPI` et le mot de passe est `admin`
```bash
mysql -u root -padmin -e "CREATE USER 'GLPI'@'localhost' IDENTIFIED BY 'admin';"
```

#### E. Edition des permissions
```bash
mysql -u root -padmin -e "GRANT ALL PRIVILEGES ON GLPI.* TO 'GLPI'@'localhost';"
```

#### F. Fuseau Horaire
```
# mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -padmin -u root mysql
# GRANT SELECT ON `mysql`.`time_zone_name` TO 'GLPI'@'localhost';
# FLUSH PRIVILEGES;
mysql -u root -padmin -e "GRANT SELECT ON mysql.time_zone_name TO 'GLPI'@'localhost';"
```

#### G. Déconnexion MYSQL
```bash
quit;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
## III. Installation du site
#### A. Installation du site
```
clear;
LANGUE=fr_FR
HOST=localhost
DATABSE=GLPI
USERNAMEDB=GLPI
PASSDB=admin

/var/www/html/glpi/bin/console db:install \
--reconfigure \
--default-language=$LANGUE \
--db-host=$HOST \
--db-port=3306 \
--db-name=$DATABSE \
--db-user=$USERNAMEDB \
--db-password=$PASSDB \
--force;
```

--------------------------------------------------------------------------------------------------------------------------------------------
## IV. Configuration du site Apache (Experimantl
#### A. Install.php
Le fichier install.php doit être renommé ou Supprimé
```bash
rm /var/www/html/glpi/install/install.php;
```

#### B. Configurer le Serveur Web ([DOC](https://glpi-install.readthedocs.io/fr/latest/prerequisites.html#webserver-configuration))
Dans le but d'avoir plus d'erreur sur le Dashboard de GLPI, il faut configurer le site apache. (Chemin modifier par rapport à la doc)

```
echo"VirtualHost *:80>
        # Nom du serveur (/etc/hosts)
        ServerName debian.lan
        # Dossier Web Public
        DocumentRoot /var/www/html/glpi/public
        # Log
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        # Repertoire
        <Directory /var/www/html/glpi/public>
                Require all granted
                RewriteEngine On
                RewriteCond %{REQUEST_FILENAME} !-f
                RewriteRule ^(.*)$ index.php [QSA,L]
        </Directory>
</VirtualHost>" > /etc/apache2/sites-enabled/000-default.conf
```
<br />


--------------------------------------------------------------------------------------------------------------------------------------------
## VI. Guide d'utilisation
### A. Définir les mots de passes des comptes par défaut
```
Administration > Utilisateurs > <Nom d'utilisateur>
 > Changer les mots de passe des comptes glpi, post-only, tech et normal.
 > Jeton : Identifiant Unique
```

### B. Mettre en service le MarketPlace
```
Administration > plugins > Marketplace
 > [Nouvelle Onglet] S'enregistrer sur GLPI Network
 > Cliquer sur Connexion (En haut à droite)
 > Se connecter
 > Cliquer sur Enregistrement à Gauche
 > Copier la Clé
 
 [GLPI]
  > Renseignez votre clé d'enregistrement dans la configuration
  > Coller la clé
```

### C. Agent Inventory
```
Administration > plugins > marketplace
 > GLPI Inventory
 > 1er fois: Télécharge
 > 2nd fois: Install
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
## VII. AGENT INVENTORY (Client)
### Télécharger l'Agent Inventory
```bash
https://github.com/glpi-project/glpi-agent/releases
```


<br /><br /><br /><br /><br /><br /><br /><br />
--------------------------------------------------------------------------------------------------------------------------------------------
#### X. Modifier la page par défaut d'Apache
Pour mettre la page index.php en priorité  apache, il faut éditer la configuration du site actif.

La configuration suivante permet de définir index.php en chargement par défaut puis si il y a pas de page index.php de charger index.html.

```bash
nano /etc/apache2/sites-enabled/000-default.conf;
```
```
# Après la ligne DocumentRoot
<IfModule dir_module>
 DirectoryIndex index.php index.html
</IfModule>
```
```
a2enmod rewrite;
systemctl restart apache2;
```


