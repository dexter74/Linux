### Paquets:
```
shellcmd
```

### Désactiver sécurité:
```
pfctl -d 
```
### Clavier Azerty:
```
kbdcontrol -l /usr/share/syscons/keymaps/fr.iso.kbd
```

### Script:
```echo "kbdcontrol -l /usr/share/syscons/keymaps/fr.iso.kbd " > fr.sh
echo "pfctl -d" > firewall_off.sh;
echo "pfctl -e" > firewall_on.sh;
chmod 644 *.sh;
```
