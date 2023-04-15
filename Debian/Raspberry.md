------------------------------------------------------------------------------------------------------------------------------------------------

## <p align='center'> .: Installation de Debian sous Raspberry 3 :. </p>

------------------------------------------------------------------------------------------------------------------------------------------------

#### I. Installation du Système d'exploitation
##### Utilitaires
```
raspberry image
```

###### Operating System
```
Distributor ID : Raspbian
Description    : Raspbian GNU/Linux 11 (bullseye)
Release        : 11
Codename       : bullseye
```
<br />

------------------------------------------------------------------------------------------------------------------------------------------------
#### II. Installation de paquets
###### A. Message de Bienvenu
```bash
clear;
echo "" > /etc/motd;
```
###### X. Mise à jour
```bash
clear;
apt update;
apt upgrade -y;
```

###### X. Langue FR
```bash
echo 'LANG=fr_FR.UTF-8'   > /etc/locale.conf;
echo 'KEYMAP=fr-latin9'   > /etc/vconsole.conf;
echo 'FONT=eurlatgr'     >> /etc/vconsole.conf;
echo 'fr_FR.UTF-8 UTF-8'  > /etc/locale.gen;
locale-gen;

mkdir -p /etc/X11/xorg.conf.d/;
echo 'Section "InputClass"
    Identifier             "Keyboard Defaults"
    MatchIsKeyboard        "yes"
    Option "XkbLayout"     "fr"
    Option "XkbVariant"    "oss"
    Option "XkbOptions"    "compose:menu,terminate:ctrl_alt_bksp"
EndSection' > /etc/X11/xorg.conf.d/00-keyboard.conf;
```

###### X. Gestionnaire de session
```bash
apt install -y lightdm lightdm-gtk-greeter;
```


###### X. Utilitaires en Commande
```bash
apt install -y git;
```

###### X. XFCE4
```bash
apt install -y xfce4;
apt install -y xfce4-goodies;
apt install -y xfce4-panel-profiles;
```

###### X. XFCE4 (Panel Profiles)
```bash
git clone https://github.com/xfce-mirror/xfce4-panel-profiles.git /tmp/xfce4-panel-profiles;

cd /tmp/xfce4-panel-profiles; ./autogen.sh; make; make install;

```
###### X. DockLike
```bash
apt install -y intltool;
apt install -y dbus-x11;
rm -r /tmp/xfce4-docklike-plugin-0.4.0*;
wget --inet4-only https://archive.xfce.org/src/panel-plugins/xfce4-docklike-plugin/0.4/xfce4-docklike-plugin-0.4.0.tar.bz2 -O /tmp/xfce4-docklike-plugin-0.4.0.tar.bz2 && tar xf /tmp/xfce4-docklike-plugin-0.4.0.tar.bz2 -C /tmp;
sed -i '22  s/Épingler/Désépingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '177 s/Épingler/Désépingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '26  s/Désépingler/Épingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '190 s/Désépingler/Épingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
cd /tmp/xfce4-docklike-plugin-0.4.0/; ./configure; make -$(nproc); make install;
```

##### X. Gestion des services
```bash
systemctl start  lightdm;
systemctl enable lightdm;

```

------------------------------------------------------------------------------------------------------------------------------------------------
#### III. Note de travaille
###### A. Divers
```bash
apt install -y ukui-themes;
apt install -y ukui-greeter;
apt install -y ukui-session-manager;
Ukui Desktop Environment
```
###### B. Information
```
# Configuration Wifi:
/etc/wpa_supplicant/wpa_supplicant.conf
```
