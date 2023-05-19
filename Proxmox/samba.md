##### Paquets requis
```
sudo apt install -y cifs-utils;
sudo apt install -y ntfs-3g;
sudo apt install -y samba;
sudo apt install -y samba-common;
sudo apt install -y smbclient;
sudo apt install -y sudo;
```

##### Création des Points de montage
```bash
sudo mkdir /mnt/sd{a,b,c,d} 2>/dev/null;
```

##### FSTAB
```
clear;
echo '
# LABEL="Film"
UUID="127ccc45-40c9-4513-8f3c-382323b590b3"  /mnt/sda        ext4      defaults,nofail  0  2

# LABEL="MyArchives"
UUID=94001B57001B4022                        /mnt/sdb        ntfs-3g   defaults,nofail  0  2' >> /etc/fstab;
```

##### Création du compte utilisateur Samba
```bash
clear;
smbpasswd -a marc;
smbpasswd -e marc;
```

##### Configuration de Samba
```bash
echo '#======================= Global Settings =======================
[global]
   workgroup = WORKGROUP
#### Networking ####
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging = file
   panic action = /usr/share/samba/panic-action %d

####### Authentication #######
   server role = standalone server
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *pas>
   pam password change = yes
   map to guest = bad user

########## Domains ###########

############ Misc ############
   usershare allow guests = yes

#======================= Share Definitions =======================

[Download]
comment        = Dossier Download
path           = /mnt/sdb/MyArchive/Download
browseable     = no
writable       = yes
read only      = no
valid users    = marc
force user     = root
create mask    = 0700
directory mask = 0700
guest ok       = no

[Home]
path           = "/mnt/sdb/MyArchive/User Homes/"
browseable     = yes
writable       = yes
read only      = no
valid users    = %S
#force user     = root
create mask    = 0700
directory mask = 0700
guest ok       = no

[Music]
comment        = Dossier Music
path           = /mnt/sdb/MyArchive/Music
browseable     = yes
writable       = yes
read only      = no
valid users    = marc
force user     = root
create mask    = 0700
directory mask = 0700
guest ok       = no

[Proxmox]
comment        = Dossier Proxmox
path           = "/mnt/sdb/MyArchive/User Homes/Proxmox"
browseable     = no
writable       = yes
read only      = no
valid users    = marc
force user     = root
create mask    = 0700
directory mask = 0700
guest ok       = no

[Video]
comment        = Dossier Proxmox
path           = "/mnt/sda"
browseable     = yes
writable       = yes
read only      = no
valid users    = marc
force user     = root
create mask    = 0700
directory mask = 0700
guest ok       = no

[Windows]
comment        = Utilisateur
path           = "/mnt/sdb/MyArchive/Windows"
browseable     = yes
writable       = yes
read only      = no
valid users    = marc
force user     = root
create mask    = 0700
directory mask = 0700
guest ok       = no

;   write list = root, @lpadmin ' >  /etc/samba/smb.conf; systemctl restart smbd;



```
