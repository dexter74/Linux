#### Pré-Requis Matériel
```
CPU     :
RAM     :
GPU     :
Storage :
```

#### Information sur le système d'exploitation
```
Nom de la Distribution: Ubunyu
Nom de la Release : XXXX
Numéro de Release : XXXX
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
clear;

NIC=enp6s18
echo "# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto $NIC
allow-hotplug $NIC
iface $NIC inet static
 address 192.168.0.60
 netmask 255.255.255.0
 gateway 192.168.0.1
 dns-nameserver 192.168.0.1" >  /etc/network/interfaces; systemctl restart networking;
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
echo "" > /etc/apt/sources.list;
```

#### Mise à jour
```bash
clear;
apt update 1>/dev/null;
apt upgrade -y 1>/dev/null;
```


#### Packages
```bash
clear;
apt install -y curl         1>/dev/null;
apt install -y git          1>/dev/null;
apt install -y pip          1>/dev/null;
apt install -y python3-dev  1>/dev/null;
apt install -y python3-venv 1>/dev/null;
apt install -y radeontop    1>/dev/null;
apt install -y samba        1>/dev/null;
apt install -y samba-common 1>/dev/null;
apt install -y smbclient    1>/dev/null;
apt install -y sudo         1>/dev/null;
apt install -y unzip        1>/dev/null;

# Proxmox:
apt install -y qemu-guest-agent 1>/dev/null;
systemctl enable --now qemu-guest-agent.service 1>/dev/null;
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

#### Installation de WSDD (/etc/wsdd.conf)
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
cd $HOME;
rm -rf HOME/stable-diffusion 2>/dev/null;
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git $HOME/stable-diffusion;
cd $HOME/stable-diffusion;
python3 -m venv venv --system-site-packages;
source venv/bin/activate;
pip install -r requirements.txt 2> $HOME/error.log;
```




#### C. Edition de la configuration
```bash
mkdir $HOME/stable-diffusion/models/Lora
sed -i -e 's/\#export COMMANDLINE_ARGS\=\"\"/export COMMANDLINE_ARGS\=\"--skip-torch-cuda-test --precision full --no-half --listen \"/g' $HOME/stable-diffusion/webui-user.sh;
sed -i '/^export COMMANDLINE_ARGS=*/a export PYTORCH_HIP_ALLOC_CONF="garbage_collection_threshold:0.6,max_split_size_mb:128\"' $HOME/stable-diffusion/webui-user.sh;
sed -i '/^export PYTORCH_HIP_ALLOC_CONF\=.*/a export PYTORCH_CUDA_ALLOC_CONF\=\"garbage_collection_threshold\:0.6,max_split_size_mb:128\"' $HOME/stable-diffusion/webui-user.sh;
```
