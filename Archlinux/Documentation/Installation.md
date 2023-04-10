----------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Guide d'installation d'Archlinux </p>

----------------------------------------------------------------------------------------------------------------------------------------
#### Clavier en Azerty
```bash
loadkeys fr;
```

#### Pacman
```bash
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;
sed -i -e "s/\#ParallelDownloads = 5/ParallelDownloads = 10/g" /etc/pacman.conf;
pacman -Sy --noconfirm archlinux-keyring;
```
