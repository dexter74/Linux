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
systemctl enable --now xrdp;
```

#### Xsession
```
rm /home/marc/.xsession;
#runuser -l marc  -c 'echo "cinnamon-session" > /home/marc/.xsession';
# echo "gnome-session" > /home/marc/.xsession;
```
systemctl disable --now bluetooth.service blueman-mechanism.service
journalctl -f -b 0 | grep xrdp
```
