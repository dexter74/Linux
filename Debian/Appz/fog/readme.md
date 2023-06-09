----------------------------------------------------------------------------------------------------------------------------
# <p align='center'>Guide d'installation de FOG sur une machine Debian </p>

----------------------------------------------------------------------------------------------------------------------------
## Guide d'installation via
Lors de l'étape `* Press [Enter] key when database is updated/installed.`, il faut procéder à l'installation sur la page Web de Fog, puis valider dans la console.

#### Télécharger fog
```bash
wget https://github.com/FOGProject/fogproject/archive/master.tar.gz -O /tmp/master.tar.gz 2>/dev/null;
```

#### Extraction du fichier compresser
```bash
cd /tmp;
tar -xf master.tar.gz;
```

#### Installation de FOG (Automatique)
Le mot de passe de la SQL est admin.
```bash
cd /tmp/fogproject-master/bin;
(echo "admin") | ./installfog.sh -y;
```

#### Installation de FOG (Manuel)
```
cd /tmp/fogproject-master/bin;
./installfog.sh;

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
#is running and won't be stored anywhere                               : Mot de passe du compte root de la Base de Donnée SQL

#Press [Enter] key when database is updated/installed.                 : Aller http//X.X.X.X/fog/management
                                                                       : Cliquer sur Install Now
                                                                       : Entrer dans la console
```

#### SQL
```
clear;
cat /var/www/fog//lib/fog/config.class.php | grep "DATABASE_TYPE\|DATABASE_HOST\|DATABASE_NAME\|DATABASE_USERNAME\|DATABASE_PASSWORD";
```

<br />

----------------------------------------------------------------------------------------------------------------------------
#### Windows Serveur
```
DHCP > <Nom du Serveur> > IPv4 > Etendue > Options Etendue
Configurer les options
Options 66: <IP Serveur FOG>
Options 67: undionly.kpxe
```

#### Windows
```
Désactiver le démarrage rapide !
```

Erreur :
![image](https://github.com/dexter74/Linux/assets/35907/c6f06ec4-f058-40ef-a6f7-eafe9739c9c7)


#### Sauvegarde / Restauration
```
Démarrer en PXE puis il faut choisir le menu d'inscription de la machine
Sous FOG
 > Images > Create New Image
  > Ceci permet de créer un groupe pour la capture

 > Hosts > List All Hosts
  > Cliquer sur l'icône Capture
   > Host Image: Choisir le "groupe".
  > Cliquer sur l'icône Deploy
```
----------------------------------------------------------------------------------------------------------------------------
```
# Package: apt install -y apache2 bc build-essential cpp curl g++ gawk gcc genisoimage gettext git gzip htmldoc isolinux lftp libapache2-mod-php libc6 libcurl4 liblzma-dev m4 mariadb-client mariadb-server net-tools nfs-kernel-server openssh-server php php-bcmath php-cli php-curl php-fpm php-gd php-intl php-json php-ldap php-mbstring php-mysql php-mysqlnd tar tftpd-hpa tftp-hpa unzip vsftpd wget zlib1g

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
