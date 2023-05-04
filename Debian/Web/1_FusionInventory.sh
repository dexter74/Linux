######################################################################################################################################
# Plugin GLPI : FusionInventory #
#################################

# GLPI 9.5
FILE=https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/glpi9.5%2B4.2/fusioninventory-9.5+4.2.tar.bz2
wget $FILE -O /tmp/fusioninventory-9.5+4.2.tar.bz2;
tar -xvf  /tmp/fusioninventory-9.5+4.2.tar.bz2 -C /var/www/html/glpi/plugins;
chown -R www-data:www-data /var/www/html/glpi/plugins;

# GLPI 10.0
FILE=https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/glpi10.0.6%2B1.1/fusioninventory-10.0.6+1.1.tar.bz2 
wget $FILE -O /tmp/fusioninventory-10.0.6+1.1.tar.bz2
tar -xvf  /tmp/fusioninventory-10.0.6+1.1.tar.bz2 -C /var/www/html/glpi/plugins;
chown -R www-data:www-data /var/www/html/glpi/plugins;

######################################################################################################################################
# Activation du Plugin #
########################
Configuration 
- Plugins 
- FusionInventory 
> Installer 
> Activer

######################################################################################################################################
# Tâches Planifiées #
#####################
# Récupérer la version de php : echo $(php --version | head -n 1 | cut -d 'P' -f 3 | cut -d '(' -f 1 | cut -c 2-4)

# Crontab
cd /var/spool/cron;
crontab -e;

#Studi: (Erreur)
* * * * * /usr/bin/php /var/www/html/glpi/front/cron.php &>/dev/null

# Documentation
* * * * * cd /var/www/html/glpi/front/ && /usr/bin/php cron.php &>/dev/null

######################################################################################################################################
# Relancer le service Cron #
############################
systemctl restart cron;
systemctl status  cron;

######################################################################################################################################
# Activer les tâches Cron #
###########################
Configuration 
- Actions automatiques
- Taskscheduler
-> Exécuter 
-> Sauvegarder

systemctl enable --now apache2;
systemctl enable --now cron;
systemctl enable --now mariadb;
systemctl enable --now fusioninventory-agent.service;

######################################################################################################################################
# Agent FusionInventory #
#########################

# Fonction:
- Il peut également faire une découverte de tous les matériels réseau autour de sa machine (modules NetDiscovery et NetInventory). Le module
Deploy permet de réaliser du déploiement de logiciels et la fonction Wake-on-lan est intégrée.

Windows: https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.6/fusioninventory-agent_windows-x64_2.6.exe

Installation:
 - Type d'installation: Complète
 - Serveur: http://192.168.1.53/glpi/plugins/fusioninventory/

Forcer la Maj: http://localhost:62354
	     : Force an Inventory


Linux : Remplacer dans la commande SED l'adresse IP Du serveur
apt install -y fusioninventory-agent;
cp /etc/fusioninventory/agent.cfg /etc/fusioninventory/agent.cfg.old;
sed -i -e 's/^#server = http:\/\/server.domain.com\/glpi\/plugins\/fusioninventory\//server = http:\/\/192.168.1.53\/glpi\/plugins\/fusioninventory\//' /etc/fusioninventory/agent.cfg
fusioninventory-agent;
systemctl disable --now fusioninventory-agent.service;
systemctl enable  --now fusioninventory-agent.service;

######################################################################################################################################
# Serveur #
###########
Cliquer sur l'accueil de GLPI puis dans Ordinateurs
