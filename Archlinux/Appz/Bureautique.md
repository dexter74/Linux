
##### Logiciels
```bash
pacman -Sy --noconfirm discord;
pacman -Sy --noconfirm file-roller;
pacman -Sy --noconfirm gnome-{calculator,calendar,font-viewer,terminal};
pacman -Sy --noconfirm numlockx;
pacman -Sy --noconfirm rhythmbox;
pacman -Sy --noconfirm seahorse;
pacman -Sy --noconfirm smplayer;
pacman -Sy --noconfirm virtualbox virtualbox-guest-iso virtualbox-host-modules-arch;
echo "* 192.168.1.0/24
* 192.168.2.0/24
* 192.168.3.0/24
* 192.168.4.0/24
* 192.168.5.0/24" > /etc/vbox/networks.conf;

runuser -l $USERNAME -c 'yay -Sy --noconfirm blivet-gui';
runuser -l $USERNAME -c 'yay -Sy --noconfirm menulibre';
runuser -l $USERNAME -c 'yay -Sy --noconfirm microsoft-edge-stable-bin';
runuser -l $USERNAME -c 'yay -Sy --noconfirm mugshot';
runuser -l $USERNAME -c 'yay -Sy --noconfirm mpc-qt';
runuser -l $USERNAME -c 'yay -Sy --noconfirm pamac-aur';
runuser -l $USERNAME -c 'yay -Sy --noconfirm protonup-qt';
runuser -l $USERNAME -c 'yay -Sy --noconfirm rhythmbox-plugin-hide-git';
runuser -l $USERNAME -c 'yay -Sy --noconfirm rhythmbox-plugin-tray-icon';
runuser -l $USERNAME -c 'yay -Sy --noconfirm rhythmbox-tray-icon';
runuser -l $USERNAME -c 'yay -Sy --noconfirm sysmontask';
runuser -l $USERNAME -c 'yay -Sy --noconfirm timeshift';
runuser -l $USERNAME -c 'yay -Sy --noconfirm virtualbox-ext-oracle';
runuser -l $USERNAME -c 'yay -Sy --noconfirm xfce4-panel-profiles';
```

##### Themes
```bash
runuser -l $USERNAME -c 'yay -Sy --noconfirm dracula-gtk-theme';
runuser -l $USERNAME -c 'yay -Sy --noconfirm papirus-icon-theme-git';
runuser -l $USERNAME -c 'yay -Sy --noconfirm papirus-smplayer-theme-git';
```

##### Polices
```bash
curl https://fonts.google.com/download?family=Roboto --output /tmp/roboto.zip; unzip /tmp/roboto.zip -d /usr/share/fonts;
runuser -l $USERNAME -c 'yay -Sy --noconfirm ttf-ms-win10-auto';
```

##### Non Classé
```bash
amdvlk
dpkg
mesa-utils
opencl-mesa
systemd-ui
```
