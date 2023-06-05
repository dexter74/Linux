#### Information Système
```
Debian 11: Bullseye
```

#### Dépôt BookWorm
```
clear;
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list;
sed -i -e 's/bullseye/bookworm/g'     /etc/apt/sources.list;
apt update;
apt upgrade -y;
```


#### Pré-requis:
```bash
clear;
apt install -y ca-certificates apt-transport-https software-properties-common 1>/dev/null;
```



#### Dépôt 8.1
```bash
clear;
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list;
```

#### Installation PHP 8.1 (Inclus Modules)
```bash
# php -m 
# apt install php8.1 libapache2-mod-php8.1 1>/dev/null
#apt search php | grep dom
#apt install -y php-symfony-polyfill-ctype;
#apt install -y php-curl
#apt install -y php-dompdf php-fdomdocument php-random-compat
#apt install -y php-gd
#apt install -y php-json
#apt install -y php-libxml
#apt install -y php-zip
```

#### Apache2
```bash
apt install -y apache2 1>/dev/null;
```


#### Installation de Nextcloud
```bash
wget https://download.nextcloud.com/server/releases/latest.zip -O /tmp/Nextcloud.zip;
unzip /tmp/Nextcloud.zip -d /var/www/html/;
chown -R www-data:www-data /var/www/html/;
```
