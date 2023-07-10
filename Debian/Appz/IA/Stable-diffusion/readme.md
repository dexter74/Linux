#### Pré-Requis Matériel
```
CPU     :
RAM     :
GPU     :
Storage :
```

#### Information sur le système d'exploitation
```
Nom de la Distribution: Debian
Nom de la Release : Bullseye
Numéro de Release : 11.7
```

#### Information sur le partitionnement
| Partition | Format |
| --------- | ------ |
| 1         | EFI    |
| 2         | LVM    |

#### Informatino sur le LVM
| VP   | VG   | VL        | Format | Taille | 
| ---- | ---- | --------- | ------ | ------ |
| sda  | vg0  | Swap      | Swap   |  8 Go  |
| sda  | vg0  | System    | Swap   | 20 Go  |
| sda  | vg0  | Home      | Swap   | 10 Go  |
| sda  | vg0  | Data      | Swap   | 30 Go  |
| sda  | vg0  | TimeShift | Swap   | 60 Go  |


#### Motd
```bash
clear;
echo "" > /etc/motd;
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

#### Information sur le nom de la machine
```bash
clear;

##########################
MACHINE=StableDiffusion
Domain=lan
##########################

echo "$MACHINE" > /etc/hostname

echo "#### IPV4
127.0.0.1       localhost
127.0.1.1       $MACHINE.lan  $MACHINE

#### IPV6
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts
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
apt install -y curl;
apt install -y git;
apt install -y pip;
apt install -y python3-dev;
apt install -y samba;
apt install -y samba-common;
apt install -y smbclient;
apt install -y sudo;
apt install -y unzip;
```

#### Sudoers L'utilisateur
```bash
clear;
echo "marc ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/admin;
```


#### Création de l'utilisateur Samba
```bash
clear;
smbpasswd -x marc 1>/dev/null 2>/dev/null;
(echo "admin"; echo "admin") | smbpasswd -a marc 1>/dev/null;
smbpasswd -e marc 1>/dev/null;
systemctl restart smbd;
```

#### Configuration de Samba
```bash
clear;

echo "client min protocol = NT1
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

[System]
comment        = Acces au dossier root
path           = /
browseable     = yes
writable       = yes
read only      = no
valid users    = marc
force user     = root
guest ok       = no

#[NomdemonPartage]
#comment 	= Mon commentaire
#path		= /chemin
#browseable 	= yes | no (Partage Visible ou cacher)
#writable 	= yes | no 
#write list     = # Si writable absent

#read only 	= yes | no
#valid users 	= USER1, USER2, @groupe12000 %S  (Utilisateurs, Groupe ou Services autorisés)
#force user	= utilisateur de substitution
#create mask 	= 0700 (Conseiller) | 0755 (déconseiller)
#directory mask	= 0700 (Conseiller) | 0755 (déconseiller)			
#guest ok	= no | yes (Permet aux clients de se connecter au répertoire partagé sans fournir de mot de passe.)" >  /etc/samba/smb.conf; systemctl restart smbd;
```

#### Installation de WSDD
```bash
wget -O- https://pkg.ltec.ch/public/conf/ltec-ag.gpg.key | gpg --dearmour > /usr/share/keyrings/wsdd.gpg;
source /etc/os-release;
echo "deb [signed-by=/usr/share/keyrings/wsdd.gpg] https://pkg.ltec.ch/public/ ${UBUNTU_CODENAME:-${VERSION_CODENAME:-UNKNOWN}} main" > /etc/apt/sources.list.d/wsdd.list;
apt update;
apt install wsdd;
systemctl enable --now wsdd;
```


#### Stable-Diffusion
```bash
clear;
wget https://github.com/cmdr2/stable-diffusion-ui/releases/download/v2.5.24/Easy-Diffusion-Linux.zip;
unzip Easy-Diffusion-Linux.zip;
cd easy-diffusion;
bash start.sh;

# Dependances: 	libgl1
# /home/marc/easy-diffusion/scripts/on_sd_start.sh 
```
