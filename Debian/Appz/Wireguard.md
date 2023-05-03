------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation d'un Serveur Wireguard et des clients </p>

------------------------------------------------------------------------------------------------------------------------
#### Génération de la configuration (Exemple)
```
https://www.wireguardconfig.com
```

![image](https://user-images.githubusercontent.com/35907/235902601-6a678645-ff75-4d08-9262-607764b620a8.png)

Seed:
```
lORM1DSdwfzsA4NskzgwOOrsz9flKMzWpwJJrzQY8YIfjiDId46Ry8S80Lbve+Fg5OzhJcaQ6nHHx8hoyo1Y27OLIe1Z7BMCn+H2g2b5zbK7kuCwSJa7uBNZH7DEPboQT/ZlxKWzoeLwIuTnXCoV3+ihEzBVbpskWmCCM6bsnHJcw9zeZpujueV8SBm3BgFLVwbHBq8yurGoZxZnqqaPNwHkR03bqhY/6gQvwTM9JvNuu0sEyuzq/OUQmp4tcz+3M/E47DrIro/TDdrdsTFzQgLY6AWgPbU5B1OSDB7LwPJNbWFVMYCHAfOM9CaMOBot4utO3cGeX+G3jYGkB6pvAA==
```

#### Nettoyage de Wireguard
```
apt autoremove --purge -y wireguard > /dev/null;
rm -r /etc/wireguard/*;
systemctl daemon-reload;
```

#### Dépôt Backport
```
echo "deb http://deb.debian.org/debian $(lsb_release -c | cut -c 11-20)-backports main" >  /etc/apt/sources.list.d/buster-backports.list;
```

#### Installation de IPTABLES
```bash
apt update > /dev/null;
apt install -y iptables
```

#### Installation de Wireguard
```bash
apt update > /dev/null;
apt install -y wireguard > /dev/null;
mkdir  /etc/wireguard;
```

#### Autoriser le trafic inter-réseau
```bash
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf;
/sbin/sysctl -w net.ipv4.ip_forward=1; 
```

#### Arrêt du services
```bash
systemctl disable --now wg-quick@wg0;
```

#### Clé Publique et Privée
```bash
echo "OCpejhwDHLLuOXyhmxv9MU+s4FWM8ZEsUs0pyvrqZEA=" > /etc/wireguard/privatekey;
echo "zj9mJKH4r8CL0dQz+DqGxPiZvdO7zvAuE/ztFwOhBUQ=" > /etc/wireguard/publickey;
```

#### Configuration du Serveur
```bash
echo "[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = OCpejhwDHLLuOXyhmxv9MU+s4FWM8ZEsUs0pyvrqZEA=
PostUp   = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ens18 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ens18 -j MASQUERADE

[Peer]
PublicKey = GqYCPBrwBj1v7f4S7HfX4zkG6hZfgZsCjLPDJq4zxQg=
AllowedIPs = 10.0.0.2/32

[Peer]
PublicKey = 7epVMA/arEQhIqeukMAyWPyqgjIRcMbUSbQCM06zNw8=
AllowedIPs = 10.0.0.3/32

[Peer]
PublicKey = UaMiX5Pk26GSG0dON74qQIRcIdIKgmIcNG3+4f+WP38=
AllowedIPs = 10.0.0.4/32

[Peer]
PublicKey = KkiC/yLZTztDJ76sAhY+2ytS9+i8B4yWTLXqKUT2TDQ=
AllowedIPs = 10.0.0.5/32

[Peer]
PublicKey = E8TqxuDqvhdxTRWQUD67sRSUwShLon8/zX/12ow2bDU=
AllowedIPs = 10.0.0.6/32" > /etc/wireguard/wg0.conf;
````

#### Permission de fichier
```bash
sudo chmod 600 -R /etc/wireguard/;
```

#### Lancement du service
```bash
systemctl restart wg-quick@wg0;
```
<br />

------------------------------------------------------------------------------------------------------------------------
#### Clients
```
[Interface]
PrivateKey = cCedBWuep+QdedyUeYHZNKEa/OfGp8r2+p89dkDJN20=
ListenPort = 51820
Address = 10.0.0.2/24

[Peer]
PublicKey = zj9mJKH4r8CL0dQz+DqGxPiZvdO7zvAuE/ztFwOhBUQ=
AllowedIPs = 192.168.0.0/24, 0.0.0.0/0, ::/0
Endpoint = 192.168.0.20:51820


-------------------------------------------------------------------------
[Interface]
Address = 10.0.0.3/24
ListenPort = 51820
PrivateKey = eM3IgPYevDoxvgh3cJjM2sQca6HWDVeL1N4Y7XDInnE=
DNS = 192.168.0.1

[Peer]
PublicKey = zj9mJKH4r8CL0dQz+DqGxPiZvdO7zvAuE/ztFwOhBUQ=
AllowedIPs = 192.168.0.0/24, 0.0.0.0/0, ::/0
Endpoint = 192.168.0.20:51820

-------------------------------------------------------------------------
[Interface]
Address = 10.0.0.4/24
ListenPort = 51820
PrivateKey = EMmWLWmR7miu34PWajdZ4vKr2hxKb0sCPx4EOf3wnnM=
DNS = 192.168.0.1

[Peer]
PublicKey = zj9mJKH4r8CL0dQz+DqGxPiZvdO7zvAuE/ztFwOhBUQ=
AllowedIPs = 192.168.0.0/24, 0.0.0.0/0, ::/0
Endpoint = 192.168.0.20:51820

-------------------------------------------------------------------------
[Interface]
Address = 10.0.0.5/24
ListenPort = 51820
PrivateKey = KAPUCv3ZCdfIWtCtQsJI8fk7XuXnz4knXsa4rrOtb2w=
DNS = 192.168.0.1

[Peer]
PublicKey = zj9mJKH4r8CL0dQz+DqGxPiZvdO7zvAuE/ztFwOhBUQ=
AllowedIPs = 192.168.0.0/24, 0.0.0.0/0, ::/0
Endpoint = 192.168.0.20:51820
```
