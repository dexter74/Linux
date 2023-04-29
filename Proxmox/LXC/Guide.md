--------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Création d'un Conteneur LXC sous Debian disposant de Docker </p>
--------------------------------------------------------------------------------------------------------------------------------------------

#### Création du conteneur LXC
```
Distributor ID           : Debian
Description              : Debian GNU/Linux 11 (bullseye)
Release                  : 11
Codename                 : bullseye
Conteneur non privilégié : A définir
Fonctionnalité           : A définir
```


#### Accés SSH
```
sed -i -e 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config;
nano /etc/ssh/sshd_config;
systemctl restart ssh;
systemctl status ssh;
```
