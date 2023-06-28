-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> .: Installation de Centreon via le fichier OVA sous Virtualbox :. </p>

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Installation de Centreon ([https://docs.centreon.com/fr/docs/installation/installation-of-a-central-server/using-virtual-machines/](Doc))
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
