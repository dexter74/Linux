------------------------------------------------------------------------------------------------------------------------------------------------

## <p align='center'> .: Installation de Archlinux sous Raspberry 3 :. </p>

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

###### B. Mise à jour
```bash
clear;
apt update;
apt upgrade -y;
```

###### C. Environnement Graphique
```bash
apt install -y xfce4;
apt install -y xfce4-goodies;
```

###### D. Gestionnaire de session
```
apt install -y lightdm lightdm-gtk-greeter;
systemctl start lightdm;
```




------------------------------------------------------------------------------------------------------------------------------------------------
#### III. Note de travaille
###### A. Divers
```bash
apt install -y ukui-themes;
apt install -y ukui-greeter;
apt install -y ukui-session-manager;
```

###### B. Information
```
# Configuration Wifi:
/etc/wpa_supplicant/wpa_supplicant.conf
```
