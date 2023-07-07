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
1005 Dozzle
1110 qBitTorrent
1111 Jackett
1112 Radarr
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




## Règle WAN:
J'ai crée 1 règle pour les ports TCP et 1 règle pour les ports TCP pour permettre le franchissement via ses ports et protocoles dédiées.

J'autorise le ping entre le WAN et le LAN uniquement. (192.168.0.0/24 vers 192.168.10.0/24)

![image](https://github.com/dexter74/Linux/assets/35907/4e6cbe48-75d2-4e4e-a8ed-4cc6f9cbc9b1)

<br />

## Règle LAN:
J'ai crée 1 règle pour les ports TCP et 1 règle pour les ports TCP pour permettre le franchissement via ses ports et protocoles dédiées.

Tout le reste est bloqué

J'autorise le ping depuis le LAN.

![image](https://github.com/dexter74/Linux/assets/35907/a094e2e7-c23a-4f18-8d6f-d4a190fd7608)


