------------------------------------------------------------------------------------------------------------------------------------------------

## <p align='center'> .: Installation de Archlinux sous Raspberry 3 :. </p>

------------------------------------------------------------------------------------------------------------------------------------------------

#### Information sur le Système
```
RPI-Image      : Oui (Pré-configurer : Wifi, User)
Distributor ID : Raspbian
Description    : Raspbian GNU/Linux 11 (bullseye)
Release        : 11
Codename       : bullseye
```

#### Installation de paquets
```
clear:
echo "" > /etc/motd;
apt update;
apt upgrade -y;
apt install -y xfce4;
apt install -y xfce4-goodies;

apt install -y lightdm lightdm-gtk-greeter;
systemctl start lightdm;
```

#### Divers
```bash
apt install -y ukui-themes;
apt install -y ukui-greeter;
apt install -y ukui-session-manager;
```


#### Information
```
# Configuration Wifi:
/etc/wpa_supplicant/wpa_supplicant.conf
```
