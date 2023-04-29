#### Création du fichier Credentials
```
mkdir /etc/credentials;
# Création du fichier .smbpassword:
echo "username=
password=
vers=3.0
file_mode=0777
dir_mode=0777
workgroup=WORKGROUP
_netdev" > /etc/credentials/.smbpassword;

nano /etc/credentials/.smbpassword;
chmod 600 /etc/credentials/.smbpassword;
````
