#### Installation de Rsync
```
apt install -y rsync
```

#### Création d'un dossier
```
mkdir /root/rsync;
touch /root/rsync/monfichier;
```

#### Réalisation d'une sauvegarde
```
#Localement
rsync -avz /root/rsync /tmp/;

# SRV1 vers SRV2
rsync -avz /root/rsync root@192.168.0.5:/root/rsync;
rsync -e ssh -avz /root/rsync/ root@192.168.0.5:/root/rsync;
```

#### Réaliser de la restauration
```
rsync -avz /tmp/ /root/rsync;

# SRV2 vers SRV1
rsync -avz /root/rsync root@192.168.0.50:/root/rsync;
rsync -e ssh -avz /root/rsync/ root@192.168.0.50:/root/rsync;
```
