#### Debian 11 ISO
```
https://cdimage.debian.org/cdimage/archive/11.7.0/amd64/iso-dvd/
```

#### Langue
```
localectl set-x11-keymap fr pc105 fr terminate:ctrl_alt_bksp;

echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen;locale-gen;
```

#### Mode Debug:
```bash 
bash -x monscript.sh
```
