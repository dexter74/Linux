#### Problème Boot
```
pacman -R xf86-video-fbdev;
```

##### Serveur d'affichage
```bash
clear;
sudo pacman -Sy --noconfirm xorg-server xorg-xinit 1>/dev/null;
```

##### Pilotes AMD
```bash
clear;
sudo pacman -Sy --noconfirm xf86-video-amdgpu 1>/dev/null;
```

##### Pilotes Vesa
```bash
clear;
sudo pacman -Sy --noconfirm xf86-video-vesa 1>/dev/null;
```

##### Pilotes VMWare
```bash
clear;
sudo pacman -Sy --noconfirm xf86-video-vmware 1>/dev/null;
```
