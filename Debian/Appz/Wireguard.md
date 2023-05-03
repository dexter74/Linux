#### Nettoyage de Wireguard
```
apt autoremove --purge -y wireguard > /dev/null;
rm -r /etc/wireguard;
systemctl daemon-reload;
```

#### Dépôt Backport
```
echo "deb http://deb.debian.org/debian $(lsb_release -c | cut -c 11-20)-backports main" >  /etc/apt/sources.list.d/buster-backports.list;
```

#### Installation de Wireguard
```bash
apt update > /dev/null;
apt install -y wireguard > /dev/null;
```

#### Autoriser le trafic inter-réseau
```bash
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf;
/sbin/sysctl -w net.ipv4.ip_forward=1; 
```

#### Arrêt des services (Maintenance
```bash
systemctl disable --now wg-quick@wg0;
```

#### Clé Publique et Privée
```bash
mkdir  /etc/wireguard;
echo "" > /etc/wireguard/privatekey;
echo "" > /etc/wireguard/publickey;
```

#### Configuration du Serveur
```bash
echo "" > /etc/wireguard/wg0.conf;
````

#### Permission de fichier
```bash
sudo chmod 600 -R /etc/wireguard/;
```
