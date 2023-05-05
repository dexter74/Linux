------------------------------------------------------------------------------------------------

### <p align='center'> Guide d'installation de Debian 11 sous Virtualbox </p>

<br /> 
<p align='center'>
	<img src='https://linuxhint.com/wp-content/uploads/2019/08/5-27-810x455.png'>
</p>

------------------------------------------------------------------------------------------------

#### I. Présentation de l'installation
L'installation de Debian se fera sans choisir un seul package.
L'interface sera Cinnamon

------------------------------------------------------------------------------------------------

#### II. Packages de base

##### A. Modifier les Sources par défaut

###### Sauvegarde de la configuration
```
cp /etc/apt/sources.list /etc/apt/sources.list.old;
```
###### Modification des sources
```
sed -i -e "s/^deb cdrom/#deb cdrom/g" /etc/apt/sources.list;
echo 'deb http://ftp.fr.debian.org/debian bullseye main contrib non-free
deb-src http://ftp.fr.debian.org/debian bullseye main contrib non-free' > /etc/apt/sources.list.d/bullseye.list
```
##### B. Mettre à jour la liste des paquets
```
apt update;
```
##### C. Installation des packages
```
apt install -y amd64-microcode;
apt install -y bash-completion;
apt install -y cifs-utils;
apt install -y exfat-utils; 
apt install -y man;
apt install -y ntfs-3g;
apt install -y openssh-server;
apt install -y linux-headers-$(uname -r);
# apt install -y software-properties-gtk;
```
##### D. Configuration OpenSSH
```
sed -i -e 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config;
systemctl restart ssh;
```
##### E. Virtualbox Guest Additions

###### Installation des dépendances
```
apt install -y build-essential dkms;
```
###### Installation de VirtualBox Guest Additions
```
apt install -y virtualbox-guest-additions-iso;
mkdir /media/virtualbox;
mount /usr/share/virtualbox/VBoxGuestAdditions.iso /media/virtualbox;
/media/virtualbox/VBoxLinuxAdditions.run;
systemctl enable --now vboxadd.service;
# Construire module pour tout les noyaux: /sbin/rcvboxadd quicksetup all;
```
<br />

------------------------------------------------------------------------------------------------
#### III. Serveur D'affichage

##### A. Présentation de Xorg
<p align='center'> <img src='https://plumf.eu/content/images/2022/01/x-architecture-1.webp'> </p> 

##### B. Installation de X11
```
# Minimum + startx + glxinfo
apt install -y xserver-xorg-core xinit mesa-utils;

# xf86-input-keyboard
# xf86-input-mouse
mkdir -p /usr/share/fonts/X11/cyrillic;
mkdir -p /usr/share/fonts/X11/100dpi;
mkdir -p /usr/share/fonts/X11/75dpi;
mkdir -p /usr/share/fonts/X11/Type1;
```

##### B. Définir la langue en FR sur Xorg
```
echo 'Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "fr"
EndSection' > /etc/X11/xorg.conf.d/00-keyboard.conf;
```

##### C. Installer le pilote Carte-graphique
```
lspci | grep VGA

# -------------------------------------------------------
apt install -y xserver-xorg-video-vmware;
# -------------------------------------------------------
# apt install -y xserver-xorg-all;
# apt install -y xserver-xorg-video-cirrus;
# apt install -y xserver-xorg-video-fbdev;
# apt install -y xserver-xorg-video-qxl;
# apt install -y xserver-xorg-video-vesa;
# -------------------------------------------------------
# apt install -y xserver-xorg-video-intel;
# apt install -y xserver-xorg-video-nouveau;
# apt install -y xserver-xorg-video-nvidia;
# apt install -y xserver-xorg-video-nvidia-legacy-390xx;
# apt install -y xserver-xorg-video-ati;
# apt install -y xserver-xorg-video-radeon;
# apt install -y xserver-xorg-video-amdgpu;
# -------------------------------------------------------
```

##### D. Configurer Xorg
```
### Générer configuration
# Xorg -configure;

# Tester configuration
# X -config /root/xorg.conf.new;

# Placer fichier de configuration
# mv /root/xorg.conf.new /root/xorg.conf;
```
<br />

------------------------------------------------------------------------------------------------
#### IV. Gestionnaire de connexions 

##### A. Installation de Lightdm
```
apt install -y lightdm;
systemctl enable lightdm;
```
##### B. Définir le gestionnaire de connexions par défaut
```
dpkg-reconfigure lightdm;
```
<br />

------------------------------------------------------------------------------------------------
#### V. Cinnamon
##### A. Installation de base
```
apt install -y cinnamon cinnamon-desktop-environment cinnamon-l10n;
```
##### B. Redémarrage du PC
```
reboot;
```
<br />

------------------------------------------------------------------------------------------------
### Annexe: 

##### [PulseAudio](https://wiki.debian.org/fr/PulseAudio)


| Environnement de Bureau | Fournit automatiquement PulseAudio  |
| ----------------------- | ----------------------------------- |
| Cinnamon 				  | OUI									|
| Gnome 				  | OUI									|
| KDE 					  | OUI									|
| LXDE 					  | NON									|
| Mate 					  | OUI									|
| XFCE	 				  | NON									|


**Mixeurs**
```
pavucontrol
```

**Relancr PulseAudio**
```
systemctl --user restart pulseaudio.service
```


###### Note
```
# Pacakage:
# - numlockx
# -----------------------------------------------------
# locale
# -----------------------------------------------------
# localectl
# -----------------------------------------------------
# /etc/locale.gen
# /etc/default/keyboard
# echo "KEYMAP=fr-latin9" > /etc/vconsole.conf
# -----------------------------------------------------

##### Configuration de X (Clavier)
# dpkg-reconfigure keyboard-configuration
# systemctl restart keyboard-setup
```

##### Utilisateur en Root
```
echo "marc ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/marc
```
