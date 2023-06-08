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
rsync -avz /root/rsync /tmp/;
rsync -avz /root/rsync root@192.168.0.5:/root/rsync
rsync -e ssh -avz /root/rsync/ root@192.168.0.5:/root/rsync
```
