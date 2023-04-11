#### Supprimer Xfce4-panel ([ici](https://unix.stackexchange.com/questions/38048/how-to-remove-all-the-panels-in-xfce))
Pour supprimer tout les tableaux de bord, il faut supprimer les lignes suivantes.

```bash
cp /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml.old
sed -i '24d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
sed -i '23d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
sed -i '22d' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml;
cat -n /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml
```



```bash
nano -n /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml
<property name="Client2_Command" type="array">
<value type="string" value="xfce4-panel"/>
</property>
```

