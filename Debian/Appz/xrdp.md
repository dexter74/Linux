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
