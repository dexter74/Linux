-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> .: Installation de Centreon sur Debian (En cours de test) :.</p>

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Configuration de la machine Debian
#### A. Définir un nom de machine
```bash
hostnamectl set-hostname centreon-central
```


<br /> 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Installation de Centreon [DOCUMENTATION](https://docs.centreon.com/fr/docs/installation/installation-of-a-central-server/using-packages/)
#### A. Mise à jour du système
```bash
apt update     1>/dev/null;
apt upgrade -y 1>/dev/null;
```

#### B. Installation des outils
```bash
apt install -y lsb-release ca-certificates apt-transport-https software-properties-common wget gnupg2 1>/dev/null;
```

#### C. Dépôt Sury APT pour PHP 8.1
```bash
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list;
wget -O- https://packages.sury.org/php/apt.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/php.gpg  > /dev/null 2>&1;
apt update 1>/dev/null;
```

#### D. MariaDB
```bash
curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash -s -- --os-type=debian --os-version=11 --mariadb-server-version="mariadb-10.5";
```

#### E. Dépôt Centreon 23.04
```bash
echo "deb https://packages.centreon.com/apt-standard-23.04-stable/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/centreon.list;
echo "deb https://packages.centreon.com/apt-plugins-stable/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/centreon-plugins.list;

wget -O- https://apt-key.centreon.com | gpg --dearmor | tee /etc/apt/trusted.gpg.d/centreon.gpg > /dev/null 2>&1;
apt update 1>/dev/null;
```

#### F. Installation de Centreon 
```bash
apt install -y centreon;
systemctl daemon-reload;
systemctl restart mariadb;
```

#### G. Définir le fuseau horaire de Centreon
```bash
echo "date.timezone = Europe/Paris" >> /etc/php/8.1/mods-available/centreon.ini;
```

#### H. Relance du service PHP
```bash
systemctl restart php8.1-fpm;
```





