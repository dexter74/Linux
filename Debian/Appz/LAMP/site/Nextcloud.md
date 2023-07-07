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
apt upgrade -y 1>/dev/null;
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
apt install -y libapache2-mod-php 1>/dev/null;
apt install -y php                1>/dev/null;
apt install -y php-ldap           1>/dev/null;
apt install -y php-bcmath         1>/dev/null;
apt install -y php-curl           1>/dev/null;
apt install -y php-gd             1>/dev/null;
apt install -y php-gmp            1>/dev/null;
apt install -y php-intl           1>/dev/null;
apt install -y php-mbstring       1>/dev/null;
apt install -y php-mysql          1>/dev/null;
apt install -y php-xml            1>/dev/null;
apt install -y php-zip            1>/dev/null;
# php -m;
# apt search php | grep -i XXX;
```

#### C. Switch PHP 7 vers PHP 8.
```bash
clear;

# Désactiver PHP
/usr/sbin/a2dismod php*;

# Activation de PHP 8.2
/usr/sbin/a2enmod php8.2;
```

# Activation du Module ldap
```bash
/usr/sbin/a2enmod ldap;
```

#### E. Relance d'Apache
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
wget https://download.nextcloud.com/server/releases/latest.zip -O /tmp/Nextcloud.zip 2>/dev/null;
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

Si à la fin l'URL est KO, revenir juste en arrière et c'est terminé.
```


#### D. Authentification par Active Directory (LDAP)

/!\ Si le compte de service venait à ne plus marcher, Nextcloud ne marchera plus !

```
Active Directory
 - Affichage > Fonctions avancés (Permet de récupérer le distinguishedName)
 - Crée un compte utilisateur "LDAP" (Sans permission) et définir le mot de passe avec aucune expiration.
 - Editer l'utilisateur > Éditeurs d'attributs
 - Chercher la ligne "distinguishedName" puis double clique sur la valeur
 - Copier la valeur (Bloc Note)

Nextcloud:
 - Avatar > Applications > Packs d'application > LDAP user and group backend (Installé et Activation)
 - Avatar > Panels d'administrations > Integration LDAP/AD (Descendre un peu)
 
 [Integration LDAP/AD]
 > Hôte: Adresse IP du serveur AD
 > Port: 189 (TCP/UDP) ou cliquer sur "Détecter le port"
 > DN utilisateur: Coller la valeur mis dans le bloc Note . (Exemple: CN=ldap,CN=Users,DC=LAN,DC=LOCAL)
 > Mot de passe: Taper le mot de passe du compte LDAP
 > Ne pas cocher la case ""Évite les requêtes LDAP automatiques ..."
 > Cliquer sur Détecter le DN de base"
   > Message : Configuration OK
 > Cliquer sur Continuer
 > Attributs: 
  Cocher la case "Adresse électronique LDAP/AD :" si vous avez une serveur Exchange

 > Groups:
  Sélectionner vos Groupes que vous autoriser à s'authentifier sur Nextcloud
  Puis cliquer sur la flèche
  Cliquer sur le bouton "Vérifier les paramètres et compter les groupes"
  Sa afficher le nombre de groupe à droite du bouton . (Exemple: 3 groupes trouvés)
 - Avatar > Utilisateurs
```

#### E. Gestion des données LDAP
```
Avatar
 > Paramètres 
 > Utilisateurs
 > Paramètres (En bas à gauche)
 > Cocher "Afficher l'origine du Compte"
 
Dans la colonne "Nom d'affichage" il y a le nom d'utilisateur et on voit une Numéro (Exemple: marc 2B414487-7824-46EC-9F15-261FB9BF415C)
Ceci est le dossier de l'utilisateur dans le dossier /var/www/html/nextcloud/data

Pour mon utilisateur marc : /var/www/html/nextcloud/data/2B414487-7824-46EC-9F15-261FB9BF415C
```

![image](https://github.com/dexter74/Linux/assets/35907/aefe3edc-d746-4337-a028-41fe9afdd1bb)

<br />

------------------------------------------------------------------------------------------------------------------------------------
#### X. Activation du module Header
```bash
a2enmod headers;
```

#### X.Prise en charge du Header pour le HTTPS
Ajouter après `<VirtualHost _default_:443>` les lignes suivantes:
```
nano /etc/apache2/sites-enabled/default-ssl.conf;
    <IfModule mod_headers.c>
            Header always set Strict-Transport-Security "max-age=15552000; >
    </IfModule>
```

------------------------------------------------------------------------------------------------------------------------------------
#### X. Configurer PHP 8.2
```
PHP_VERSION=8.2
sed -i -e 's/^output_buffering \=/\; output_buffering \=/g' /etc/php/$PHP_VERSION/apache2/php.ini;
sed -i -e 's/memory_limit \= 128M/memory_limit \= 512M/g' /etc/php/$PHP_VERSION/apache2/php.ini;
systemctl restart apache2;
```

#### X. Configurer Apache2
```
# Remplacer la ligne 172 (none en all)
sed -i '172s/None/all/' /etc/apache2/apache2.conf; systemctl restart apache2;
```

#### X. Correctif Erreur (FIX URL)
![image](https://github.com/dexter74/Linux/assets/35907/9d0fa705-7d63-4def-a313-71f0881f9dbb)
```
cp /var/www/html/nextcloud/config/config.php /var/www/html/nextcloud/config/config.php.old
nano /var/www/html/nextcloud/config/config.php
L'adresse IP n'est plus celle de la machine.
Sous 0 => 'X.X.X.X', ajouter : 1=> '0.0.0.0',
```

#### X. Problème rencontré lors de l'installation
```
Si à l'installation de Nextcloud, la page indique des modules manquants il faut faire apt install php-<nom du module> et la console affiche qu'il demande un texte en explicite donc se sera apt install php8.2-<module php>
Puis il faudra relancer le service apache.
```
