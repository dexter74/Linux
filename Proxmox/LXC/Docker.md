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
apt install -y ca-certificates curl gnupg net-tools;
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

#### Docker-compose
```
curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose;
chmod +x /usr/local/bin/docker-compose;
docker-compose --version;
```

#### Libérer le port 53 pour ADGuardHome ([Gude](https://github.com/AdguardTeam/AdGuardHome/wiki/FAQ#bindinuse))
```
lsof -i :53;
mkdir -p /etc/systemd/resolved.conf.d;
echo "[Resolve]
DNS=127.0.0.1
DNSStubListener=no" > /etc/systemd/resolved.conf.d/adguardhome.conf;
mv /etc/resolv.conf /etc/resolv.conf.backup;
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf;
systemctl reload-or-restart systemd-resolved;
```
