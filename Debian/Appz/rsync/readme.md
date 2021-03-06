---------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Mise en place d'une sauvegarde planifiée via le SSH</p>


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### A. Installation de Rsync
```
apt install -y rsync;
```

#### B. Installation de SSHPASS
Permet de la connexion ssh sans devoir indiquer le mot de passe.
```
apt install -y sshpass;
```

#### C. Se connecter sur le serveur Distant
Lorsqu'on ouvre la connexion sur un serveur à distant, le terminal indiquera qu'il faut récupérer la signature et une fois fait on pourras se déconnecter.


#### D. Création d'un dossier rsync
```
mkdir /root/rsync;
touch /root/rsync/monfichier;
```

#### E. Réalisation d'une sauvegarde (Local, Distant
```
# Local
rsync -avz /root/rsync /tmp/;

# Distant (192.168.0.50 vers 192.168.0.5)
rsync -avz /root/rsync root@192.168.0.5:/root/rsync;
sshpass -p admin rsync -e ssh -avz /root/rsync/ root@192.168.0.5:/root/rsync > /var/log/rsync.log;
```

#### F. Réaliser de la restauration
```
# Local
rsync -avz /tmp/rsync /root/;

# Distant (192.168.0.5 vers 192.168.0.50)
rsync -avz /root/rsync root@192.168.0.50:/root/rsync;
rsync -e ssh -avz /root/rsync/ root@192.168.0.50:/root/rsync;

sshpass -p admin rsync -e ssh -avz /root/rsync/ root@192.168.0.50:/root/rsync > /var/log/rsync.log;
```

#### G. Plannifié une sauvegarde ([AIDE à la planif de Cron](https://crontab.guru/))
```
# Supprimer toute les tâches
crontab -r;

# Vérifier les tâches
crontab -l;

# Editer les Tâches plannifiés:
crontab -e;

# Lancement de la synchronisation (Tout les minutes) 
*/1 * * * * sshpass -p admin rsync -e ssh -avz /root/rsync/ root@192.168.0.5:/root/rsync > /var/log/rsync.log;

# Relancer le service
systemctl restart cron;

# Surveille log
tail -f /var/log/rsync.log;
```

#### H. Script (start.sh)
```
#!/bin/bash

#################################################################
# Information:                                                  #
# - Sauvegarde d'un dossier local vers serveur distant via SSH  #
#################################################################

# Local
SOURCE=/root/rsync/
LOG=/var/log/rsync.log

# SSH
SSH_SERV=192.168.0.X
SSH_USER=root
SSH_PASS=admin
DESTINATION=/root/rsync/

echo "Lancement de rsync"
sshpass -p $SSH_PASS rsync -e ssh -avz $SOURCE $SSH_USER@$SSH_SERV:$DESTINATION > $LOG;
echo "Processus rsync terminé"
```
