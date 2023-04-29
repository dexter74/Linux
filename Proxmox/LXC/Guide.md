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

#### Installation des prérequis
```bash
apt update;
apt install -y ca-certificates curl gnupg;
```

#### Dépôt
```bash
install -m 0755 -d /etc/apt/keyrings; curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg; chmod a+r /etc/apt/keyrings/docker.gpg;
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null;
````

#### Installation
```bash
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
```
