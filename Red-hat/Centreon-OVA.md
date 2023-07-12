-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> .: Installation de Centreon via le fichier OVA sous Virtualbox :. </p>

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Installation de Centreon ([DOCUMENTATION](https://docs.centreon.com/fr/docs/installation/installation-of-a-central-server/using-virtual-machines))
#### Se connecter en root
```
Identifiant: root
Mot de passe: centreon
```
#### Changer le Fuseau Horaire (Europe/Paris)
```bash
timedatectl set-timezone Europe/Paris;
timedatectl; # Permet de vérifier le fuseau horaire
```

#### Installation du Paquet Nano
Le paquet nano permet une édition des fichiers de manière plus simple
```bash
yum install nano;
```

#### Edition de la configuration de PHP (Centreon
```bash
nano /etc/php.d/50-centreon.ini;
# Remplacer America_New_York en  Europe/Paris;
```

#### Relancer le service PHP
```bash
systemctl restart php-fpm;
```

#### Définir le nom de machine
```bash
hostnamectl set-hostname centreon;
```

#### Action Utilisateur Centreon
```bash
su - centreon;
/bin/php /usr/share/centreon/cron/centreon-partitioning.php;
exit;
```

#### Relance des services
```bash
systemctl restart cbd centengine gorgoned
```

#### Accès au panel Web
```bash
Panel Web    : http://X.X.X.X/centreon (X.X.X.X est l'adresse IP du serveur)
Identifiant  : admin
Mot de passe : Centreon!123

Attention au mot de passe. (C en majuscule et ! avant 123)
```



#### Récupérer le nom de l'interface
```
ip add
```
![image](https://github.com/dexter74/Linux/assets/35907/ceae8889-089d-41b1-8677-114a587e55c7)


#### Edition du fichier de configuration de l'interface. (ens18)
```
nano /etc/sysconfig/network-scripts/ifcfg-ens18;
```

```
# DHCP en static
BOOTPROTO=static

# Définir IP Statique
IPADDR=
GATEWAY=
NETMASK=
DNS1=X.X.X.X
DNS2=X.X.X.X
```

```
systemctl restart networking;
```


#### Gestionnaire de Base de donnée
```bash
clear;
yum install unzip;

VERSION=5.2.1
cd /usr/share/centreon/www/;
wget https://files.phpmyadmin.net/phpMyAdmin/$VERSION/phpMyAdmin-$VERSION-all-languages.zip -O  /usr/share/centreon/www/phpMyAdmin.zip;
unzip /usr/share/centreon/www/phpMyAdmin.zip;
mv phpMyAdmin-5.2.1-all-languages phpmyadmin;
chown -R centreon:centreon /usr/share/centreon/www/;
rm  /usr/share/centreon/www/phpMyAdmin.zip;
```

http://X.X.X.X/centreon/phpmyadmin/
