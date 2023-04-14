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
```

#### Définir le mot de passe (Login: root | Mot de passe: admin)
```
echo "root:admin" | chpasswd;
```


#### Se connecter en SSH
```
ssh root@127.0.0.1 -p 27015
```
