---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de xrdp pour faire du Bureau à Distance </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#### Installation du Paquet
```bash
apt install -y xrdp;
```

#### Gestion du service
```bash
systemctl enable --now xrdp;
```

#### Ajouter le compte xrdp au groupe ssl-group
```bash
adduser xrdp ssl-cert;
```
