-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de Fusion Inventory </p>

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### GLPI 9.5.X
Si vous avez installé GLPI 9.5.X, alors utiliser la version 9.5.X de Fusion Inventory.
```bash
FILE=https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/glpi9.5%2B4.2/fusioninventory-9.5+4.2.tar.bz2
wget $FILE -O /tmp/fusioninventory-9.5+4.2.tar.bz2;
tar -xvf /tmp/fusioninventory-9.5+4.2.tar.bz2 -C /var/www/html/glpi/plugins;
chown -R www-data:www-data /var/www/html/glpi/plugins;
```
### GLPI 10.0.6
Si vous avez installé GLPI 10.0.6, alors utiliser la version10.0.6 de Fusion Inventory.
```bash
FILE=https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/glpi10.0.6%2B1.1/fusioninventory-10.0.6+1.1.tar.bz2 
wget $FILE -O /tmp/fusioninventory-10.0.6+1.1.tar.bz2
tar -xvf /tmp/fusioninventory-10.0.6+1.1.tar.bz2 -C /var/www/html/glpi/plugins;
chown -R www-data:www-data /var/www/html/glpi/plugins;
```
<br />

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Activation du Plugin
```
Configuration 
- Plugins 
- FusionInventory 
> Installer 
> Activer
```
### Tâches Planifiées (Cron)
##### Connaitre la version de PHP
```bash
 echo $(php --version | head -n 1 | cut -d 'P' -f 3 | cut -d '(' -f 1 | cut -c 2-4)
```

##### Création de la Tâche
```bash
crontab -e;
```
```bash
* * * * * /usr/bin/php /var/www/html/glpi/front/cron.php &>/dev/null
```

#### Relancer le service Cron
```bash
systemctl restart cron;
systemctl status  cron;
```

#### Activer les tâches Cron 
```
Configuration 
- Actions automatiques
- Taskscheduler
-> Exécuter 
-> Sauvegarder
```
<br />

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### Installation de l'agent FusionInventory (Linux)
```bash
apt install -y fusioninventory-agent;
```

### Sauvegarde Fichier original
Permet de revenir en Arrière en cas de problème via le fichier original.
```bash
cp /etc/fusioninventory/agent.cfg /etc/fusioninventory/agent.cfg.old;
```

#### Configurer l'adresse GLPI pour l'agent
Remplacer l'adresse `192.168.0.10`par l'adresse de votre serveur GLPI.
```bash
sed -i -e 's/^#server = http:\/\/server.domain.com\/glpi\/plugins\/fusioninventory\//server = http:\/\/192.168.0.10\/glpi\/plugins\/fusioninventory\//' /etc/fusioninventory/agent.cfg
fusioninventory-agent;
```

#### Restaurer le fichier original (En cas d'erreur)
Permet de restaure le contenu du fichier original dans le fichier de configuration.
```bash
cat /etc/fusioninventory/agent.cfg.old >  /etc/fusioninventory/agent.cfg;
```

#### Relancer les services
Relance du serveur Web, Cron, MariaDB (BDD) et de l'agent Fusion Inventory;
```bash
systemctl enable --now apache2;
systemctl enable --now cron;
systemctl enable --now mariadb;
systemctl enable --now fusioninventory-agent.service;
```

#### Fonction de l'agent Inventory
```
- Il peut également faire une découverte de tous les matériels réseau autour de sa machine (modules NetDiscovery et NetInventory). Le module
Deploy permet de réaliser du déploiement de logiciels et la fonction Wake-on-lan est intégrée.
```

#### Windows
```
https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.6/fusioninventory-agent_windows-x64_2.6.exe
Installation:
 - Type d'installation: Complète
 - Serveur: http://192.168.0.10/glpi/plugins/fusioninventory/
 ```

#### Côté Client (Forcer la MAJ)
```
Aller à l'adresse de bouclage sur le port 65354 : http://localhost:62354
puis cliquer sur Force an Inventory
```

#### Côté GLPI
```
Cliquer sur l'accueil de GLPI puis dans Ordinateurs
```
