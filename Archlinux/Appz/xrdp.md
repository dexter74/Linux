[GUIDE](https://gist.github.com/valorad/7fd3e4a7fb4481f1eb77ded42a72537d)

#### Installation du Paquet
```bash
yay -Sy --noconfirm xrdp xorgxrdp-git;
```

##### /etc/X11/Xwrapper.config
```bash
# Allow anybody to start X:
allowed_users=anybody
```

##### /etc/xrdp/sesman.ini
```bash
[Xorg]
param=/usr/lib/Xorg
# Leave the rest of the lines untouched
#...
```

##### xinit
```bash
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```
