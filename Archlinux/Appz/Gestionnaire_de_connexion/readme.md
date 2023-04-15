##### Gestion de la session (+ thème Lightdm-evo)
```bash
sudo pacman -Sy --noconfirm lightdm;
```

##### Suppléments
```bash
sudo pacman -Sy --noconfirm lightdm-gtk-greeter;
sudo pacman -Sy --noconfirm lightdm-gtk-greeter-settings;
sudo pacman -Sy --noconfirm lightdm-webkit2-greeter;
```

##### Thèmes (A compléter)
```bash
sudo git clone https://github.com/AlphaNecron/lightdm-evo.git /usr/share/lightdm-webkit/themes/lightdm-evo;
sudo sed -i 's/\#greeter-session\=example-gtk-gnome/greeter-session\=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf;
sudo sed -i 's///g' /etc/lightdm/lightdm-webkit2-greeter.conf;
```

##### Services
```bash
sudo systemctl disable --now lightdm;
sudo systemctl enable  --now lightdm;
```


----------------------------------------------------------------------------------------------------------------------------------------------------------
