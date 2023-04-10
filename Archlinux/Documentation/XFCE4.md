#### Supprimer Xfce4-panel ([ici](https://unix.stackexchange.com/questions/38048/how-to-remove-all-the-panels-in-xfce))
```
nano /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml
<property name="Client2_Command" type="array">
<value type="string" value="xfce4-panel"/>
</property>
```
