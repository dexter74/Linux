#### Pré-requis:
```bash
apt install -y \
ca-certificates \
apt-transport-https \
software-properties-common \
1>/dev/null;
```

#### Apache2
```bash
apt install -y apache2 1>/dev/null;
```

#### PHP 8.1
```bash
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list;
apt install php8.1 libapache2-mod-php8.1 1>/dev/null
```


#### Installation de Nextcloud
```bash
wget https://download.nextcloud.com/server/releases/latest.zip -O /tmp/Nextcloud.zip;
```
