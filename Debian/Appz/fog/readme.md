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

# Désinstallation
./installfog.sh --uninstall

# Lancement de l'installation
(echo "2"; echo "N"; echo "N"; echo "N"; echo "N";  echo "N"; echo "Y"; echo "N"; echo "N"; echo "Y"; echo "Y"; echo "y"; echo "$PASSWORD_ROOT_SQL") | ./installfog.sh;

re you sure you wish to continue (Y/N) y

#Choice                                                                : 2
#What type of installation would you like to do [N/s (Normal/Storage)] ? N
#Would you like to change the default network interface from ens18     ? N
#Would you like to setup a router address for the DHCP server [Y/n]    ? N
#Would you like DHCP to handle DNS [Y/n]                               ? N
#Would you like to use the FOG server for DHCP service                 ? N
#You like to install the additional language packs                     ? Y
#Would you like to enable secure HTTPS on your FOG server              ? N
#Would you like to change it                                           ? N
#Are you ok with sending this information                              ? Y
#Are you sure you wish to continue                                     ? Y
# Password SQL root                                                    : admin
```

