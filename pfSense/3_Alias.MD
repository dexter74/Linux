------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Pfsense - Alias pour mon réseau local </p>
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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


![image](https://github.com/dexter74/Linux/assets/35907/4e6cbe48-75d2-4e4e-a8ed-4cc6f9cbc9b1)
