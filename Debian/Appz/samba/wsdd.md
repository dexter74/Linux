https://github.com/christgau/wsdd

```
wget -O- https://pkg.ltec.ch/public/conf/ltec-ag.gpg.key | gpg --dearmour > /usr/share/keyrings/wsdd.gpg;
source /etc/os-release;
echo "deb [signed-by=/usr/share/keyrings/wsdd.gpg] https://pkg.ltec.ch/public/ ${UBUNTU_CODENAME:-${VERSION_CODENAME:-UNKNOWN}} main" > /etc/apt/sources.list.d/wsdd.list;
apt update;
apt install wsdd;
systemctl enable --now wsdd;
```
