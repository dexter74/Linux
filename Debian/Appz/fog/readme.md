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
mysql -u root -padmin -e "ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');"

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

# Purge (SQL et Fichier)
./installfog.sh --uninstall
mysql -u root -padmin -e "DROP DATABASE IF EXISTS fog; DROP USER IF EXISTS 'fogstorage'@'%'; DROP USER IF EXISTS 'fogmaster'@'localhost';"
rm -rf /etc/apache2/sites-enabled/001-fog*            2>/dev/null;
rm -rf /etc/apache2/sites-available/001-fog.*         2>/dev/null;
rm -rf /var/lib/apache2/site/enabled_by_admin/001-fog 2>/dev/null;
userdel -r fogproject                                 2>/dev/null;
rm -rf /var/www/fog                                   2>/dev/null;
rm -rf /var/www/html/fog                              2>/dev/null;
rm -rf /opt/fog                                       2>/dev/null;
rm -rf /tftpboot                                      2>/dev/null;
rm -rf /images                                        2>/dev/null;

# Lancement de l'installation
(echo "2"; echo "N"; echo "N"; echo "N"; echo "N"; echo "N"; echo "Y"; echo "N"; echo "N"; echo "Y"; echo "Y"; echo "admin"; echo "") | ./installfog.sh 1>/dev/null;



# Package: apt install -y apache2 bc build-essential cpp curl g++ gawk gcc genisoimage gettext git gzip htmldoc isolinux lftp libapache2-mod-php libc6 libcurl4 liblzma-dev m4 mariadb-client mariadb-server net-tools nfs-kernel-server openssh-server php php-bcmath php-cli php-curl php-fpm php-gd php-intl php-json php-ldap php-mbstring php-mysql php-mysqlnd tar tftpd-hpa tftp-hpa unzip vsftpd wget zlib1g
```


