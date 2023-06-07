--------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide d'installation d'un serveur LAMP </p>

--------------------------------------------------------------------------------------------------------------------------------
#### Présentation
**L**inux **A**pache **M**ysql et **P**HP



--------------------------------------------------------------------------------------------------------------------------------
#### Installation des Paquets de base
```bash
clear;
apt install -y curl;
apt install -y unzip;
apt install -y wget;
```

#### Apache
```bash
apt install -y apache2;
```

#### MariaDB
```bash
apt install -y mariadb-server;

(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "admin"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```

#### Dépôt PHP 8
```bash
clear;
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list; apt update 1>/dev/null;
```

#### PHP
```bash
apt install -y php;
```
