--------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Guide d'installation d'un serveur LAMP </p>

--------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
**L**inux **A**pache **M**ysql et **P**HP
<br />

```
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list
```
--------------------------------------------------------------------------------------------------------------------------------
## II. Installation des Paquets de base
```bash
clear;
apt install -y curl  1>/dev/null;
apt install -y unzip 1>/dev/null;
apt install -y wget  1>/dev/null;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
## III. Apache
```bash
apt install -y apache2 1>/dev/null;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
### IV. MariaDB
```bash
clear;
PASS_ROOT_SQL=admin

apt install -y mariadb-server 1>/dev/null;
(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "$PASS_ROOT_SQL"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```
<br />

--------------------------------------------------------------------------------------------------------------------------------
## V. PHP
#### A. PHP 7
```bash
apt list --installed | grep php;
apt remove --purge php-*;
apt remove --purge php;
apt install -y php;
```
#### B. PHP8
```bash
clear;
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list; apt update 1>/dev/null;
apt install -y php;
```

