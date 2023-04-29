--------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Création d'un Conteneur LXC disposant de Docker </p>
--------------------------------------------------------------------------------------------------------------------------------------------

#### Accés SSH
```
sed -i -e 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config;
nano /etc/ssh/sshd_config;
systemctl restart ssh;
systemctl status ssh;
```
