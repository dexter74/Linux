### VirtualBox 7.X
Le package des Guest additions dans le dépôt officiel n'est pas à jour.

```
# Root Requis: su -
apt install -y linux-headers-amd64; # $(uname -r);
apt install -y build-essential dkms;

mount /sr0 /media/cdrom0;
cd /media/cdrom0;
sh *.run;
```



