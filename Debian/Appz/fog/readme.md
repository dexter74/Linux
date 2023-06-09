----------------------------------------------------------------------------------------------------------------------------
# <p align='center'>Guide d'installation de FOG sur une machine Debian </p>

----------------------------------------------------------------------------------------------------------------------------

#### Panel Web
```
Login: fog
Passw: password
```

#### SQL
```
cat /var/www/fog//lib/fog/config.class.php | grep "DATABASE_TYPE\|DATABASE_HOST\|DATABASE_NAME\|DATABASE_USERNAME\|DATABASE_PASSWORD" | cut -d "'" -f 4

Ligne 1: Type SQL
Ligne 2: Host SQL
Ligne 3: Nom de la Base de donnée
Ligne 4: Identifiant SQL
Ligne 5: Mot de passe

Autoriser PHPMYADMIN:
PASSWORD=tmKU584T6gx@IZokzIAQ
mysql -u fogmaster -p$PASSWORD
mysql -u root -e "ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');"
```

#### Guide d'installation via un script FOG
```bash
# Nettoyage de la console
clear;

# Variable d'environnement
FOG=https://github.com/FOGProject/fogproject/archive
RELEASE=1.5.10.tar.gz
PASSWORD_ROOT_SQL=admin

# Dossier TMP
cd /tmp;

# Purge (Silent Mode)
rm -rf /tmp/fogproject* 2>/dev/null;

# Téléchargement
wget $FOG/$RELEASE -O fogproject.tar.gz 2>/dev/null;

# Extraction du fichier
tar -xf fogproject.tar.gz;

# Déplacement dans le dosssier Fog
cd fogproject-*;

# Déplacement dans bin
cd bin;

# Purge
rm -rf /var/www/fog      2>/dev/null;
rm -rf /var/www/html/fog 2>/dev/null;
rm -rf /opt/fog          2>/dev/null;
rm -rf /tftpboot         2>/dev/null;
rm -rf /images           2>/dev/null;

# Lancement de l'installation
(echo "2"; echo "N"; echo "N"; echo "N"; echo "N"; echo "N"; echo "Y"; echo "N"; echo "N"; echo "Y"; echo "Y"; echo "admin"; echo "") |./installfog.sh;


# Q01] Choice                                                                : 2
# Q02] What type of installation would you like to do [N/s (Normal/Storage)] ? N
# Q03] Would you like to change the default network interface from ens18     ? N
# Q04] Would you like to setup a router address for the DHCP server [Y/n]    ? N
# Q05] Would you like DHCP to handle DNS [Y/n]                               ? N
# Q06] Would you like to use the FOG server for DHCP service                 ? N
# Q07] You like to install the additional language packs                     ? Y
# Q08] Would you like to enable secure HTTPS on your FOG server              ? N
# Q09] Would you like to change it                                           ? N
# Q10] Are you ok with sending this information                              ? Y
# Q11] Are you sure you wish to continue                                     ? Y
# Q12] Password SQL root                                                     : admin
# Q13] Press [Enter] key when database is updated/installed.                 : Entré

# /tmp/fogproject-1.5.10/bin/error_logs/fog_error_1.5.10.log


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! The installer was not able to run all the way to the end as   !!
!! something has caused it to fail. The following few lines are  !!
!! from the error log file which might help us figure out what's !!
!! wrong. Please add this information when reporting an error.   !!
!! As well you might want to take a look at the full error log   !!
!! in /tmp/fogproject-1.5.10/bin/error_logs/fog_error_1.5.10.log !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
             --> ERROR: Module php does not exist
             └─33497 php-fpm: pool www
juin 09 23:26:42 fog systemd[1]: Starting The PHP 7.4 FastCGI Process Manager...
juin 09 23:26:42 fog systemd[1]: Started The PHP 7.4 FastCGI Process Manager.
ERROR 1146 (42S02) at line 1: Table 'fog.globalSettings' doesn't exist

# Package
apt install -y apache2 bc build-essential cpp curl g++ gawk gcc genisoimage gettext git gzip htmldoc isolinux lftp libapache2-mod-php libc6 libcurl4 liblzma-dev m4 mariadb-client mariadb-server net-tools nfs-kernel-server openssh-server php php-bcmath php-cli php-curl php-fpm php-gd php-intl php-json php-ldap php-mbstring php-mysql php-mysqlnd tar tftpd-hpa tftp-hpa unzip vsftpd wget zlib1g
```

