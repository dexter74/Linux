-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> .: Installation de Centreon sur Debian (En cours de test) :.</p>

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Préparation de l'environnement Linux

#### X. Définir un nom de machine
```bash
clear;
hostnamectl set-hostname centreon-central
```

#### X. Mise à jour du système
```bash
apt update     1>/dev/null;
apt upgrade -y 1>/dev/null;
```

#### X. Installation des outils
```bash
clear;
apt install -y  apt-transport-https ca-certificates curl gnupg2 lsb-release software-properties-common wget 1>/dev/null;
```

#### X. Installation de MariaDB
```bash
clear;
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | bash -s -- --os-type=debian --os-version=11 --mariadb-server-version="mariadb-10.5";

PASS_ROOT_SQL=admin
apt install -y mariadb-server 1>/dev/null;
(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "$PASS_ROOT_SQL"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```

#### X. Dépôt Sury APT pour PHP 8.1
```bash
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list;
wget -O- https://packages.sury.org/php/apt.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/php.gpg  > /dev/null 2>&1;
apt update 1>/dev/null;
```

<br /> 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II.  ([Guide](https://docs.centreon.com/fr/docs/installation/installation-of-a-central-server/using-packages/) | [Securisation](https://docs.centreon.com/fr/docs/administration/secure-platform/#activer-firewalld) )




#### E. Dépôt Centreon 23.04
```bash
clear;
echo "deb https://packages.centreon.com/apt-standard-23.04-stable/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/centreon.list;
echo "deb https://packages.centreon.com/apt-plugins-stable/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/centreon-plugins.list;

wget -O- https://apt-key.centreon.com | gpg --dearmor | tee /etc/apt/trusted.gpg.d/centreon.gpg > /dev/null 2>&1;
apt update 1>/dev/null;
```

#### F. Installation de Centreon 
```bash
clear;
apt install -y centreon;
systemctl daemon-reload;
systemctl restart mariadb;
```

#### G. Définir le fuseau horaire de Centreon
```bash
clear;
echo "date.timezone = Europe/Paris" >> /etc/php/8.1/mods-available/centreon.ini;
```

#### H. Relance du service PHP
```bash
clear;
systemctl restart php8.1-fpm;
```

#### I. Activation des services linux
```bash
clear;
systemctl enable php8.1-fpm apache2 centreon cbd centengine gorgoned centreontrapd snmpd snmptrapd
```
