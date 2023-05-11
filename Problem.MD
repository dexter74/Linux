#### Découverte Réseau
```
systemctl disable avahi-daemon.service;


echo "[main]
systemd-resolved=false" > /etc/NetworkManager/conf.d/no-systemd-resolved.conf;
systemctl restart systemd-resolved.service;
systemctl enable --now systemd-resolved.service;
systemctl status systemd-resolved.service;
```
