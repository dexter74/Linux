#### Pré-requis:
```bash
apt install -y \
ca-certificates \
apt-transport-https \
software-properties-common \
1>/dev/null;
```

#### PHP 8.1
```bash
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list;
apt install php8.1 libapache2-mod-php8.1 1>/dev/null
```

PHP (see System requirements for a list of supported versions)
PHP module ctype
PHP module curl
PHP module dom
PHP module GD
PHP module JSON (included with PHP >= 8.0)
PHP module libxml (Linux package libxml2 must be >=2.7.0)
PHP module mbstring
PHP module openssl (included with PHP >= 8.0)
PHP module posix
PHP module session
PHP module SimpleXML
PHP module XMLReader
PHP module XMLWriter
PHP module zip
PHP module zlib

#### Modules
```bash
php -m 
apt search php | grep dom
apt install -y php-symfony-polyfill-ctype;
apt install -y php-curl
apt install -y php-dompdf php-fdomdocument php-random-compat
apt install -y php-gd
apt install -y php-json
apt install -y php-libxml
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
apt install -y php-
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
