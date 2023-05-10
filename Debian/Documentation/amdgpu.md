### RX 6700
```bash
clear;
sed -i -e "s/bullseye main non-free/bullseye-backports main non-free/g" /etc/apt/sources.list;
apt update;
apt upgrade -y;
apt install -y firmware-amd-graphics;
```
