#### XFCE4
```bash
pacman -Sy --noconfirm xfce4 xfce4-dev-tools xfce4-goodies xfce4-datetime-plugin xfce4-whiskermenu-plugin;
```

#### Suppléments
```bash
yay -Sy --noconfirm xfce4-panel-profiles;
pacman -Sy --noconfirm libgsf libopenraw ffmpeg ffmpegthumbnailer libgepub poppler poppler-glib;
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
