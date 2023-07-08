------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Pfsense - Alias pour mon réseau local </p>
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Pour le réseau `LAN`, il faudra choisir `LAN net` pour la source. 

### 1. Alias IP
```
Nom : WAN_PARE_FEU
IP  : 192.168.0.4

Nom : LAN1_PARE_FEU
IP  : 192.168.10.1

Nom : LAN2_PARE_FEU
IP  : 192.168.20.1
```

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### 2. Alias ports
Certains ports sont inutiles à ouvrir, car les ports sont non existants sur votre environnement. 
```
Nom         : LAN_TCP
Description : Ports TCP ouverts côté LAN
Port(s)     :

22 SSH
53 DNS
80 HTTP
81 Nginx Reverse Proxy
90 FreshRSS
443 HTTPS
445 Samba
1005 Dozzle
1110 qBitTorrent
1111 Jackett
1112 Radarr
1688 KMS Windows
3306 MySQL
3272 ADGuardHome WebUI
7777 BitWarden
8000 NAS
8006 Proxmox
8097 Jellyfin
8191 Flaresolverr
9000 Portainer
```

```
Nom         : LAN_UDP
Description : Ports UDP ouverts côté LAN
Port(s)     :
53 DNS
```


```
Nom          : WAN_TCP
Description  : Ports TCP ouverts côté WAN
Port(s)      :

22 SSH
80 HTTP
81 Nginx Reverse Proxy
389 LDAP
443 HTTPS
3389 MS-RDP
```

```
Nom          : WAN_UDP
Description  : Ports UDP ouverts côté WAN
Port(s)      :
51820 Wireguard
```

```
Nom          : Wireguard_UDP
Description  : Ports UDP ouverts côté Wireguard
Port(s)      :
53 DNS
```

```
Nom          : Wireguard_TCP
Description  : Ports TCP ouverts côté Wireguard
Port(s)      :
22 SSH
53 DNS
80 HTTP
443 HTTPS
1110 qBitTorrent
3272 ADGuardHome WebUI
7777 BitWarden
8006 Proxmox
8097 Jellyfin
9000 Portainer
```

```
Nom         : LAN_UDP_APPZ
Description : Ports UDP ouverts côté LAN
Port(s)     :
50000:50005 Discord
```

```
Nom         : LAN_TCP_APPZ
Description : Ports TCP ouverts côté LAN
Port(s)     :
```



## Règle WAN:
- Une règle pour accéder au panel Web (444*) du Pare-feu. -  (Mauvaise pratique)

- Une règle qui autorise le ping du WAN vers le Pare-Feu. (Mauvaise pratique)

- Une règle qui autorise le ping du WAN vers les machines du LAN. (Mauvaise pratique)

- Une règle qui autorise les ports TCP.

- Une règle qui autorise les ports UDP.

![image](https://github.com/dexter74/Linux/assets/35907/63bf4ab9-2aa1-4851-8663-0579c2f169e7)

Le port 80 / 443 est le port par défaut du panel, je l'ai modifié en 444.

<br />

## Règle LAN:
- Une règle pour les ports TCP.

- Une règle pour les ports UDP.

- ICMP Bloqué.

![image](https://github.com/dexter74/Linux/assets/35907/5c51a659-0e76-450b-ae1f-fe8a02157756)


<br />

## Règle Wireguard:
![image](https://github.com/dexter74/Linux/assets/35907/ecc4ecbd-3d4d-4319-ae16-a88714cc15e4)

