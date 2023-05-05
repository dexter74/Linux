---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de xrdp pour faire du Bureau à Distance </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### Installation du Paquet
```bash
apt install -y xrdp;
apt install -y spice-vdagent;
```

#### Ajouter le compte xrdp au groupe ssl-group
```bash
adduser xrdp ssl-cert;
adduser marc ssl-cert;
```

#### Gestion du service
```bash
systemctl disable --now bluetooth.service blueman-mechanism.service
systemctl enable --now xrdp;
```

#### Xsession
```
rm /home/marc/.xsession;
reboot;
```

#### Debug
```bash
journalctl -f -b 0 | grep xrdp
```

#### Supprimer Notification "Rendering hardware"
```
nano /usr/share/cinnamon/js/ui/main.js
Remplacer notifyCinnamon2d en /* notifyCinnamon2d */
```

#### Expérimental [Source](https://ishwarjagdale.github.io/wslWithGUI/)
```bash
runuser -l marc -c 'echo "cinnamon-session" > .xsession'
sudo sed -i 's/max_bpp=32/#max_bpp=32\nmax_bpp=128/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/xserverbpp=24/#xserverbpp=24\nxserverbpp=128/g' /etc/xrdp/xrdp.ini

# Commenter Ligne
nano /etc/xrdp/startwm.sh
> test -x /etc/X11/Xsession && exec /etc/X11/Xsession
> exec /bin/sh /etc/X11/Xsession
```

