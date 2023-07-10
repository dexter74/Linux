#### Pré-Requis Matériel
```
CPU     :
RAM     :
GPU     :
Storage :
```

#### Information sur le système d'exploitation
```
Debian 11
```

#### Information sur la configuration Réseau
```
echo "# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto ens18
allow-hotplug ens18
iface ens18 inet static
 address 192.168.0.60
 netmask 255.255.255.0
 gateway 192.168.0.1
 dns-nameserver 192.168.0.1" >  /etc/network/interfaces
```

#### Services
```
Samba pour permettre la gestion des données facilement
```
