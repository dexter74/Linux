#### Installation des pré-requis:
```bash
apt install -y build-essential dkms;
apt install -y linux-headers-$(uname -r);
```

#### Monter le CDROM
```
mount /dev/sr0 /media/cdrom0;
cd /media/cdrom0;
sh *.run;
```

#### Désinstaller Guest additions
```bash
vbox-uninstall-guest-additions;
```
