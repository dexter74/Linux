#### Installation
```bash
rm -rf /etc/samba/ /etc/default/samba;
apt purge   -y samba samba-common;
apt install -y samba samba-common;
apt install -y smbclient;
apt install -y avahi;
```

#### Trouver les serveurs de partage
```bash
findsmb;
```


#### Configuration
```bash
clear;
cp /etc/samba/smb.conf /etc/samba/smb.conf.old;
nano /etc/samba/smb.conf;
systemctl restart smbd;
```

#### Droit sur le partages www ([Guide](https://serverfault.com/a/994971))
```bash
clear;
smbpasswd -a marc;
smbpasswd -e marc;
systemctl restart smbd;
```

#### Edition du fichier config
```bash
nano /etc/samba/smb.conf;
systemctl restart smbd;
systemctl restart samba-ad-dc.service;
testparm -s /etc/samba/smb.conf;
```

#### Gestion des accès Samba
```bash
clear;
pdbedit -L; #Lister les utilisateur de samba
smbpasswd -a <add user>;
smbpasswd -d <disable user>;
smbpasswd -e <enable user>;
smbpasswd -n <set no password>;
smbpasswd -x <delete user>;
```

#### Windows
```bash
net use * /delete /y
```

#### Partage ([Bug](https://ubuntuforums.org/showthread.php?t=2384959))
```bash

client min protocol = NT1
client max protocol = SMB3

###################################
#        NE PAS SUPPRIMER         #
;   write list = root, @lpadmin	
###################################

# Profil Itinérant: https://wiki.samba.org/index.php/User_Home_Folders
# The [homes] feature is not supported running on a Samba Active Directory (AD) domain controller (DC).

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



#### Active Directory
```bash
####################
# Active Directory #
####################

; mkdir -p /home/samba/{netlogon,profiles}; chmod ug+rw /home/samba/profiles

[profiles]
comment        = Users profiles
path           = /home/samba/profiles
browseable     = no
create mask    = 0600
directory mask = 0700
guest ok       = no

[netlogon]
   comment = Network Logon Service
   path = /home/samba/netlogon
   guest ok = yes
   read only = yes

```

#### WWW
```bash
############################
# Droit sur le dossier www #
############################
# 
# Guide : https://api.stanleystella.com/fr_FR/page/wordpress
# chown www-data:www-data /var/www/html/ -R ;

[www] 
comment        = Dossier Apache
path           = /var/www/html
browseable     = yes
writable       = yes
read only      = no
force user     = www-data
force group    = www-data
create mask    = 0700
directory mask = 0700
```


#### Guide de création de partage
```bash
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
#guest ok	= no | yes (Permet aux clients de se connecter au répertoire partagé sans fournir de mot de passe.)
```

```
#/!\ HOMES DEJA CREE MAIS MAL CONFIG /!\
#
# homes 
# => Référence au dossier utilisateur
# => browseable = no (Evite un doublon du dossier Home et USER)
#
#
# net use * /delete /y
```
