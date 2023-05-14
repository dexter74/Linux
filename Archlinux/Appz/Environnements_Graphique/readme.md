---------------------------------------------------------------------------------------------------------------------------------------------------

[UKUI](https://github.com/ukui/ukui-desktop-environment)

---------------------------------------------------------------------------------------------------------------------------------------------------
#### XFCE4
```bash
clear;
sudo pacman -Sy --noconfirm xfce4 xfce4-dev-tools xfce4-goodies xfce4-datetime-plugin xfce4-whiskermenu-plugin 1>/dev/null;
```

#### Suppléments
```bash
clear;
sudo pacman -Sy --noconfirm libgsf libopenraw ffmpeg ffmpegthumbnailer libgepub poppler poppler-glib 1>/dev/null;
yay -Sy --noconfirm xfce4-panel-profiles 1>/dev/null;
yay -Sy --noconfirm dbus-x11 1>/dev/null;
```

#### Information
```
==> ATTENTION : Utilisation de l’arbre $srcdir/ existant
configure: WARNING: unrecognized options: --with-console-auth-dir
configure: WARNING: Sufficiently new SELinux library not found
configure: WARNING: Sufficiently new AppArmor library not found
configure: WARNING: unrecognized options: --with-console-auth-dir
dbus-connection.c: In function 'dbus_connection_remove_filter':
```



#### Docklike
```bash
clear;
rm -r /tmp/xfce4-docklike-plugin-0.4.0*;
wget --inet4-only https://archive.xfce.org/src/panel-plugins/xfce4-docklike-plugin/0.4/xfce4-docklike-plugin-0.4.0.tar.bz2 -O /tmp/xfce4-docklike-plugin-0.4.0.tar.bz2 && tar xf /tmp/xfce4-docklike-plugin-0.4.0.tar.bz2 -C /tmp;
sed -i '22  s/Épingler/Désépingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '177 s/Épingler/Désépingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '26  s/Désépingler/Épingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
sed -i '190 s/Désépingler/Épingler/'  /tmp/xfce4-docklike-plugin-0.4.0/po/fr.po;
cd /tmp/xfce4-docklike-plugin-0.4.0/; ./configure; make -$(nproc); sudo make install 1>/dev/null;
cd; sudo rm -rf /tmp/xfce4-docklike-plugin-0.4.0/;
```
<br />

#### Profil XFCE
```
clear;
wget "https://github.com/dexter74/Linux/raw/main/Archlinux/Appz/Environnements_Graphique/XFCE4_Profile.tar.bz2" -O /home/marc/Bureau/XFCE4_Profile.tar.bz2
xfce4-panel-profiles load /home/marc/Bureau/XFCE4_Profile.tar.bz2 
```

---------------------------------------------------------------------------------------------------------------------------------------------------

#### Supprimer Xfce4-panel ([ici](https://unix.stackexchange.com/questions/38048/how-to-remove-all-the-panels-in-xfce))
Pour supprimer tout les tableaux de bord, il faut supprimer les lignes suivantes.

```bash
sudo cp /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml.old
sudo sed -i '23d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
sudo sed -i '22d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
sudo sed -i '21d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
systemctl restart lightdm;
```


```bash
rm /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
curl "https://raw.githubusercontent.com/GalliumOS/xubuntu-default-settings/master/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml" > /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
systemctl restart lightdm;
```
