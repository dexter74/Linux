##### Gestion de la session (+ thème Lightdm-evo)
```bash
sudo pacman -Sy --noconfirm lightdm;
```

##### Ouvrir la session
```
Ouvrir la session une fois avant de charger le thème
```

##### Suppléments
```bash
sudo pacman -Sy --noconfirm lightdm-gtk-greeter;
sudo pacman -Sy --noconfirm lightdm-webkit2-greeter;
```

##### Téléchargr Thèmes
```bash
sudo git clone https://github.com/AlphaNecron/lightdm-evo.git /usr/share/lightdm-webkit/themes/lightdm-evo;
```

#### Configurer Lightdm
```
sudo sed -i 's/\#greeter-session\=example-gtk-gnome/greeter-session\=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf;
sudo sed -i 's/antergos/lightdm-evo/g' /etc/lightdm/lightdm-webkit2-greeter.conf;
```

##### Reverse
```bash
sudo sed -i 's/^greeter-session\=lightdm-webkit2-greeter/\#greeter-session\=example-gtk-gnome/g' /etc/lightdm/lightdm.conf;
sudo systemctl restart lightdm;
```


##### Services
```bash
sudo systemctl disable --now lightdm;
sudo systemctl restart       lightdm;
sudo systemctl enable  --now lightdm;
```



#### Note
```
sudo sed -i '/lightdm-evo/a #antergos' /etc/lightdm/lightdm-webkit2-greeter.conf;
```

----------------------------------------------------------------------------------------------------------------------------------------------------------
