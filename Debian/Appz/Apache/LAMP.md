---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide d'installation d'un serveur LAMP </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### Présentation
**L**inux **A**pache **M**ysql et **P**HP

```bash
apt install -y apache2;
apt install -y curl;
apt install -y mariadb-server;
apt install -y php;
apt install -y unzip;
```

```bash
(echo ""; echo "y"; echo "y"; echo "$PASSWORD_DB"; echo "admin"; echo "y"; echo "y"; echo "y"; echo "y") | mysql_secure_installation;
```

```bash
wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip -O /tmp/phpMyAdmin-5.2.1-all-languages.zip;
unzip /tmp/phpMyAdmin-5.2.1-all-languages.zip -d /var/www/html
mv  /var/www/html/phpMyAdmin-5.2.1-all-languages/  /var/www/html/phpmyadmin;
apt install php-mysqli;
```

```sql
# Connexion SQL:
mysql -u root -padmin

# Autoriser Accès
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('admin');

# Création du BDD
CREATE DATABASE IF NOT EXISTS STUDITEST;

# Se connecter dans la BDD
use STUDITEST;

# Création d'une Table
create table test (msg text);

# Insertion de contenu
insert into test values ('coucou');

# Afficher Contenu
select * from test;

# Quitter la SQL:
exit;
```

**Editer le Site Actif**
```
nano /etc/apache2/sites-enabled/000-default.conf;
```

**Modifier la racine du Site**
```
DocumentRoot /var/www/html
```

**Page par défaut à charger**
```
<IfModule dir_module>
    DirectoryIndex index.html index.php
</IfModule>
```


