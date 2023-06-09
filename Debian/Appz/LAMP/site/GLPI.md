--------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide de Déploiement de GLPI sous Debian </p>

--------------------------------------------------------------------------------------------------------------------------------------------
### I. Préparation Environnement
##### A. Télécharger GLPI
```bash
clear
VERSION=10.0.7
wget https://github.com/glpi-project/glpi/releases/download/$VERSION/glpi-$VERSION.tgz -O /tmp/glpi.tgz 2>/dev/null;
```

##### B. Extraire GLPI
```bash
tar -xf /tmp/glpi.tgz  -C /var/www/html;
```

##### C. Permission
```bash
chown -R www-data:www-data /var/www/html;
```

##### D. Modules PHP
```bash
# Indispensable:
apt install -y php-curl php-gd php-intl php-mysqli php-simplexml 1>/dev/null;

# Optionnel:
apt install -y php-bz2 php-ldap php-mbstring php-symfony-polyfill-ctype php-zip 1>/dev/null;
```

##### E. Relance du service Apache
```
systemctl restart apache2;
```

##### F. Vérification (Prérequis, Sécurité)
```bash
/var/www/html/glpi/bin/console glpi:system:check_requirements;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
#### II. Base De Donnée
##### A. Gestion de la Base De Donnée
```bash
clear;

# Suppression de la BDD et USER
mysql -u root -padmin -e "DROP DATABASE IF EXISTS GLPI;DROP USER IF EXISTS 'GLPI'@'localhost';"

# Création de la BDD
mysql -u root -padmin -e "CREATE DATABASE IF NOT EXISTS GLPI;"

# Création de l'utilisateur
mysql -u root -padmin -e "CREATE USER 'GLPI'@'localhost' IDENTIFIED BY 'admin';"

# Permission de la BDD pour le compte
mysql -u root -padmin -e "GRANT ALL PRIVILEGES ON GLPI.* TO 'GLPI'@'localhost';"

# Fuseau Horaire
mysql -u root -padmin -e "GRANT SELECT ON mysql.time_zone_name TO 'GLPI'@'localhost';"

# Permettre l'accès à la SQL depuis PHPMYADMIN: (MDP: GLPI)
mysql -u root -padmin -e "ALTER USER GLPI@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');"
```

<br />

--------------------------------------------------------------------------------------------------------------------------------------------
#### III. Installation du site
##### A. Installation du site
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
#### IV. Configuration du site Apache (Experimantl
##### A. Install.php
Le fichier install.php doit être renommé ou Supprimé
```bash
rm /var/www/html/glpi/install/install.php;
```

##### B. Activer le Module Rewrite
```
/usr/sbin/a2enmod rewrite;
```

##### C. Configurer le Serveur Web ([DOC](https://glpi-install.readthedocs.io/fr/latest/prerequisites.html#webserver-configuration))
Dans le but d'avoir plus d'erreur sur le Dashboard de GLPI, il faut configurer le site apache. (Chemin modifier par rapport à la doc)
```bash
nano /etc/apache2/sites-enabled/000-default.conf; systemctl restart apache2;
```
```
<VirtualHost *:80>
 # Nom du serveur (/etc/hosts)
 ServerName debian.lan

 # Dossier Web Public
 DocumentRoot /var/www/html/glpi/public
        
 # Fichier à charger par défaut (ordre)
 <IfModule dir_module>
   DirectoryIndex index.php index.html
 </IfModule>

 # Alias
 Alias "/glpi" "/var/www/html/glpi/public"

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

</VirtualHost>
```

#### D. URL Personnaliser (glpi.local)
Pour permettre d'avoir une URL personnalisée, il faut que le DNS est une entrée DNS vers la machine et qu'elle soit résolvable.

###### Vérification Résolution DNS
```
# La machine 192.168.0.5 dispose des services
# ADGuardHome est un service DNS (Création de redirection *.local vers Machine local)
# Nginx Proxy Manager

C:\Users\marc>nslookup glpi.local
 > Serveur : LXC.Docker.lan
 > Address : 192.168.0.5

Réponse ne faisant pas autorité :
Nom        : glpi.local
Address    : 192.168.0.5
```

###### Création de la configuration du site glpi.local
```
nano /etc/apache2/sites-available/glpi.local.conf;
```
```
<VirtualHost *:80>
  # Email Admin
  ServerAdmin teste74@hotmail.fr
  # Nom de la machine
  ServerName debian.lan
  # URL du site
  ServerAlias glpi.local

  # Racine du Site
  DocumentRoot /var/www/html/glpi/public

  # Chargement page dans ordre
  <IfModule dir_module>
   DirectoryIndex index.php index.html
  </IfModule>

  # Log
  ErrorLog /error.log
  CustomLog /access.log combined

 # Alias "/glpi" "/var/www/html/glpi/public"
  <Directory /var/www/html/glpi/public>
   Require all granted
   RewriteEngine On
   RewriteCond %{REQUEST_FILENAME} !-f
   RewriteRule ^(.*)$ index.php [QSA,L]
  </Directory>
</VirtualHost>
```

###### Activation du site
```
/usr/sbin/a2ensite glpi.local.conf;
```
###### Relance du site
```
systemctl restart apache2;
```
<br />


--------------------------------------------------------------------------------------------------------------------------------------------
#### VI. Guide d'utilisation
##### X. Mes préférences
```
Mon Pseudo > Mes préférences > Personnalisation
 > Mise en page	
  > Horizontal
```
##### X. Configurer le serveur
```
Configuration >  Générale
 [Configuration générale]
  > URL de l'application: http://glpi.local
 [API]
  > URL de l'API	: http://glpi.local/api
```

##### X. Définir les mots de passes des comptes par défaut
```
Administration > Utilisateurs > <Nom d'utilisateur>
 > Changer les mots de passe des comptes glpi, post-only, tech et normal.
 > Jeton : Identifiant Unique
```

 
##### X. Mettre en service le MarketPlace
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

##### X. Installer des plugins
```
Administration > plugins > marketplace
 > GLPI Inventory
  > 1er fois  : Téléchargement
  > 2nd fois  : Installer
  > 3ème fois : Activer
```


##### X. Configurer le Plugin
```
Administration > plugins > marketplace
 > GLPI Inventory
  [Bandeau Vertical]
  > Configuration générale
   > SSL seulement pour l'agent: Oui (Défaut: NON)
  > Modules des agents
   > WakeOnLan                           : ON
   > Inventaire ordinateur               : ON
   > Inventaire distant des hôtes VMware : ON
   > Inventaire réseau (SNMP)            : ON
   > Découverte réseau                   : ON
   
  [Bandeau Horizontal]
  > Déployer
   > Gestions des paquets
```
<br />

--------------------------------------------------------------------------------------------------------------------------------------------
#### VII. AGENT INVENTORY (Client)
##### Télécharger l'Agent Inventory
```bash
# Télécharger l'agent Inventory
https://github.com/glpi-project/glpi-agent/releases

# Installation
http://192.168.0.50/glpi/marketplace/glpiinventory
```

##### Inventorier le PC
```bash
http://192.168.0.10:62354/
```
