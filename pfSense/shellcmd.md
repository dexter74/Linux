# Paquets:
```
shellcmd
```
# Désactiver sécurité:
```
pfctl -d 
```
Clavier Azerty:
```
kbdcontrol -l /usr/share/syscons/keymaps/fr.iso.kbd
```


# Script:
```echo "kbdcontrol -l /usr/share/syscons/keymaps/fr.iso.kbd " > fr.sh
echo "pfctl -d" > off.sh 
echo "pfctl -e" on.sh 
chmod 644 *.sh
```

# Qemu-Agent: ([Promox](https://forum.netgate.com/topic/162083/pfsense-vm-on-proxmox-qemu-agent-installation))
```
echo qemu_guest_agent_enable="YES" > /etc/rc.conf.local; echo qemu_guest_agent_flags="-d -v -l /var/log/qemu-ga.log" >> /etc/rc.conf.local; service qemu-guest-agent start;
```
