#### Réseau NAT (Forwarding)
```
Configuration de la VM
Onglet Réseau
Mode d'accès réseau: NAT
Advanced > Redirection de Ports

Nom         : SSH
Protocole   : TCP
IP Hôte     : 127.0.0.1
Port Hôte   : 27015 (22 réserver à l'hôte)
IP Invité   : 0.0.0.0
Port invité : 22
