################################################################################################################################################
# Debian 11 + MariaDB + GLPI 9/10 par Marc Jaffré #
###################################################
RAM	: 1 Go
Data	: 8 Go (2,6 Go réel)

################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

################################################################################################################################################
# Mettre à jour le Système #
############################
apt update;
apt upgrade -y;

################################################################################################################################################
# Installation de paquet #
##########################
apt install -y apache2;
apt install -y libapache2-mod-php;
apt install -y mariadb-server;
apt install -y php;

################################################################################################################################################
# Installation des modules #
############################
apt install -y apcupsd;
apt install -y php-apcu;
apt install -y php-bz2;
apt install -y php-cas;
apt install -y php-curl;
apt install -y php-dom;
apt install -y php-gd;
apt install -y php-imap;
apt install -y php-ldap;
apt install -y php-intl;
apt install -y php-json;
apt install -y php-mbstring;
apt install -y php-mysql;
apt install -y php-fileinfo;
apt install -y php-simplexml;
apt install -y php-xmlrpc;
apt install -y php-zip;

################################################################################################################################################
# Sécuriser la Base De Donnée #
###############################
PASSWORD_DB=admin
(echo ""; echo "y" ; echo "y"; echo "$PASSWORD_DB"; echo "$PASSWORD_DB"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;

################################################################################################################################################
# Connexion à la BDD #
######################
mysql -u root -padmin;

################################################################################################################################################
# Purge Database et User #
##########################
DROP DATABASE IF EXISTS GLPI;
DROP USER IF EXISTS 'GLPI'@'localhost';

################################################################################################################################################
# Création de la BDD #
######################
CREATE DATABASE IF NOT EXISTS GLPI;

################################################################################################################################################
# Création de l'utilisateur #
#############################
CREATE USER 'GLPI'@'localhost' IDENTIFIED BY 'admin';

################################################################################################################################################
# Edition des permissions #
###########################
GRANT ALL PRIVILEGES ON GLPI.* TO 'GLPI'@'localhost';

################################################################################################################################################
# Déconnexion MYSQL #
#####################
quit;


################################################################################################################################################
# Déploiement de GLPI 9.5.12 #
##############################
FILE="https://github.com/glpi-project/glpi/releases/download/9.5.12/glpi-9.5.12.tgz"

rm -r /var/www/html/glpi 2>/dev/null;
wget "$FILE"  -O /tmp/glpi-9.5.12.tgz;
tar -xvf /tmp/glpi-9.5.12.tgz -C /var/www/html;

################################################################################################################################################
# Déploiement de GLPI 10.0.6 #
##############################
FILE="https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz"

wget "$FILE" -O /tmp/glpi-10.0.6.tgz;
rm -r /var/www/html/glpi 2>/dev/null;
tar -xvf  /tmp/glpi-10.0.6.tgz -C /var/www/html;

################################################################################################################################################
# Permission www #
##################
chown -R www-data:www-data /var/www/html/;

################################################################################################################################################
# Relancer le service Apache2 #
###############################
systemctl restart apache2;

################################################################################################################################################
# https://glpi-install.readthedocs.io/fr/develop/command-line.html#cdline-install #
###################################################################################
cd /var/www/html/glpi;
php bin/console glpi:system:check_requirements;

php bin/console db:install --reconfigure \
--default-language=fr_FR \
--db-host=localhost \
--db-port=3306 \
--db-name=GLPI \
--db-user=GLPI \
--db-password=admin \
--force;

php bin/console db:check;
php bin/console glpi:migration:timestamps;

php bin/console glpi:maintenance:enable;
php bin/console glpi:maintenance:disable;
php bin/console db:update -f;

################################################################################################################################################
# Sécurité #
############
mv /var/www/html/glpi/install/install.php     /var/www/html/glpi/install/install.php.old;
mv /var/www/html/glpi/install/install.php.old /var/www/html/glpi/install/install.php;

################################################################################################################################################
# Installer des dépendances pour phpmyadmin #
#############################################
apt upgrade -y php-tcpdf php-twig;
apt install -y -t buster-backports php-twig;

################################################################################################################################################
# phpmyadmin #
##############
wget "https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip" -O  /tmp/phpMyAdmin.zip;
unzip /tmp/phpMyAdmin.zip -d /var/www/html;
mv /var/www/html/phpMyAdmin-5.2.1-all-languages /var/www/html/phpmyadmin;
