#### Pré-requis:
```bash
apt install -y ca-certificates apt-transport-https software-properties-common wget curl lsb-release 1>/dev/null;
```

#### PHP8
```bash
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list;
```


#### Installation de Nextcloud
```bash
wget https://download.nextcloud.com/server/releases/latest.zip -O /tmp/Nextcloud.zip;
```
