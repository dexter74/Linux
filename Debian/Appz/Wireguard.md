------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation d'un Serveur Wireguard et des clients </p>

------------------------------------------------------------------------------------------------------------------------
#### Génération de la configuration (Exemple)
```
https://www.wireguardconfig.com
- Random Seed         : Clé Maître qui permet de regénérer les clés des clients. (Ne pas perdre)
- Listen Port         : Port d'écoute du serveur, qui servira à se connecter (UDP)
- Number of Clients   : Nombre de clients à générer
- CIDR                : Réseau Wireguard
- Client Allowed IPs  : Adresse réseau qui seront autorisés
- Endpoint            : Adresse du serveur Wireguard (IP ou adresse DNS)
- DNS                 : Serveur DNS qui seront utilisé par les clients. (Si le DNS est sur un réseau différent, ajouter dans AllowIP le réseau)

- Post-Up rule        : Règle de Pare-feu lorsque l'interface est Démarrer (Changer le nom de l'interface par celle qui à internet)
- Post-Down rule      : Règle de Pare-feu lorsque l'interface est arrêter
- Use Pre-Shared Keys : Envoie de clé d'authentification avant l'authentification (Augmente la sécurité)
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
apt install -y iptables;
```

#### Installation de Wireguard
```bash
apt update > /dev/null;
apt install -y wireguard > /dev/null;
apt install -y resolvconf;
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

#### Lancement du service
```bash
systemctl restart wg-quick@wg0;
```

#### Vérification du bon fonctionnement
```bash
wg;
```

<br />



------------------------------------------------------------------------------------------------------------------------
#### Clients
`clear;
nano /etc/wireguard/wg0.conf;
systemctl restart wg-quick@wg0.service`

###### Client 1
```
```

