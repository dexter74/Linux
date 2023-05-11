#### Découverte Réseau ([TOPIC](https://forums.archlinux.fr/viewtopic.php?p=179629#p179629))
```
pacman -Sy --noconfirm gvfs;
pacman -Sy --noconfirm gvfs-smb;
pacman -Sy --noconfirm gvfs-nfs;

systemctl disable avahi-daemon;
systemctl disable NetworkManager;
systemctl disable systemd-resolved;
```
