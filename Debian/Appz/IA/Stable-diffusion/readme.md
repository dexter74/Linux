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

#### Sourceslist
```
sed -i -e 's/^deb cdrom/#deb cdrom/g' /etc/apt/sources.list;

echo "deb     http://ftp.fr.debian.org/debian/           bullseye main non-free
deb-src http://ftp.fr.debian.org/debian/           bullseye main
#
deb     http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
#
deb     http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
deb-src http://ftp.fr.debian.org/debian/           bullseye-updates main contrib" > /etc/apt/sources.list;

```

#### Packages
```
apt install -y avahi;
apt install -y samba;
apt install -y samba-common;
apt install -y smbclient;
apt install -y 
```


#### Samba
```
```
