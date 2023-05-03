#### Configuration de l'interface ens18
```bash
nano /etc/network/interfaces

allow-hotplug ens18
iface ens18 inet static
  address 192.168.0.20/24
  gateway 192.168.0.1
  dns-nameservers 192.168.0.1
  dns-domain lan
```

#### Relance de l'interface
```bash
systemctl restart networking.service;
ifup ens18;
```
