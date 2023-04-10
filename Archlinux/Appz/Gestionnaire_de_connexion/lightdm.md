##### Gestion de la session (+ thème Lightdm-evo)
```bash
pacman -Sy --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm-webkit2-greeter;

git clone https://github.com/AlphaNecron/lightdm-evo.git; mv -r lightdm-evo /usr/share/lightdm-webkit/themes/lightdm-evo;
sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = lightdm-evo #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf;
sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf;
```
