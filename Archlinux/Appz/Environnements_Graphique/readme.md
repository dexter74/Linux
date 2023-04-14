---------------------------------------------------------------------------------------------------------------------------------------------------
#### XFCE4
```bash
sudo pacman -Sy --noconfirm xfce4 xfce4-dev-tools xfce4-goodies xfce4-datetime-plugin xfce4-whiskermenu-plugin;
```

#### Suppléments
```bash
sudo pacman -Sy --noconfirm libgsf libopenraw ffmpeg ffmpegthumbnailer libgepub poppler poppler-glib;
yay -Sy --noconfirm xfce4-panel-profiles;
yay -Sy --noconfirm dbus-x11;
```

#### Docklike
```bash
rm -r /tmp/xfce4-docklike-plugin-0.4.0*;
wget --inet4-only https://archive.xfce.org/src/panel-plugins/xfce4-docklike-plugin/0.4/xfce4-docklike-plugin-0.4.0.tar.bz2 -O /tmp/xfce4-docklike-plugin-0.4.0.tar.bz2 && tar xf /tmp/xfce4-docklike-plugin-0.4.0.tar.bz2 -C /tmp;
sed -i '22  s/Épingler/Désépingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '177 s/Épingler/Désépingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '26  s/Désépingler/Épingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '190 s/Désépingler/Épingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
cd /tmp/xfce4-docklike-plugin-0.4.0/; ./configure; make -$(nproc); sudo make install;
```
<br />

#### Profil XFCE
```
wget "https://github.com/dexter74/Linux/raw/main/Archlinux/Appz/Environnements_Graphique/XFCE4_Profile.tar.bz2" -O /home/marc/Bureau/XFCE4_Profile.tar.bz2
xfce4-panel-profiles load /home/marc/Bureau/XFCE4_Profile.tar.bz2 
```

---------------------------------------------------------------------------------------------------------------------------------------------------

#### Supprimer Xfce4-panel ([ici](https://unix.stackexchange.com/questions/38048/how-to-remove-all-the-panels-in-xfce))
Pour supprimer tout les tableaux de bord, il faut supprimer les lignes suivantes.

```bash
sudo sed -i '24d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
sudo sed -i '23d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
sudo sed -i '22d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
```


```bash
rm /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
curl "https://github.com/GalliumOS/xubuntu-default-settings/blob/master/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml" > /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
systemctl restart lightdm;
```
