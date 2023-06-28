--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de Centreon </p>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
https://docs.centreon.com/fr/docs/installation/installation-of-a-central-server/using-virtual-machines/
Identifiant: root
Mot de passe: centreon
timedatectl set-timezone Europe/Paris
yum install nano
nano /etc/php.d/50-centreon.ini
Remplacer America_New_York en  Europe/Paris
systemctl restart php-fpm
hostnamectl set-hostname centreon

su - centreon
/bin/php /usr/share/centreon/cron/centreon-partitioning.php
exit
systemctl restart cbd centengine gorgoned

Panel Web: http://127.0.0.1/centreon
Identifiant:  admin
Mot de passe: Centreon!123

Attention au mot de passe.

Une règle de redirection de port dans le réseau à été faite
----------------------------------------------------------------------------------------------------------------------------
