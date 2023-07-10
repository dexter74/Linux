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
```bash
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
```bash
echo "deb     http://ftp.fr.debian.org/debian/           bullseye main non-free
deb-src http://ftp.fr.debian.org/debian/           bullseye main
#
deb     http://security.debian.org/debian-security bullseye-security main contrib
deb-src http://security.debian.org/debian-security bullseye-security main contrib
#
deb     http://ftp.fr.debian.org/debian/           bullseye-updates main contrib
deb-src http://ftp.fr.debian.org/debian/           bullseye-updates main contrib" > /etc/apt/sources.list;
```

#### Mise à jour
```bash
apt update;
apt upgrade -y 1>/dev/null;
```


#### Packages
```bash
apt install -y avahi;
apt install -y samba;
apt install -y samba-common;
apt install -y smbclient;
apt install -y sudo;
```

#### Sudoers L'utilisateur
```
echo "marc ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/admin;
```


#### Samba
```
clear;
smbpasswd -a marc;
smbpasswd -e marc;
systemctl restart smbd;

cp /etc/samba/smb.conf /etc/samba/smb.conf.old;
nano /etc/samba/smb.conf;
systemctl restart smbd;

client min protocol = NT1
client max protocol = SMB3

###################################
#        NE PAS SUPPRIMER         #
;   write list = root, @lpadmin	
###################################

[homes]
comment        = Dossier Utilisateurs 
browseable     = no 
read only      = no
writable       = yes
create mask    = 0700
directory mask = 0700
guest ok       = no

[SYSTEM]
comment        = Acces au dossier root
path           = /
browseable     = yes
writable       = yes
read only      = no
valid users    = marc
force user     = root
guest ok       = no

#[homes]
#   comment = Home Directories
#   browseable = no
#   read only = yes
#   create mask = 0700
#   directory mask = 0700
#   valid users = %S
```
