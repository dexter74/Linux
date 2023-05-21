#### Credential
```
mkdir -p /etc/credential;
echo "username=marc
password=admin" > /etc/credential/.smbpassword;
chmod 0600 /etc/credential/.smbpassword;
```

#### Monter Disque dans LXC
```
echo "//192.168.0.3/Download /mnt/Download cifs uid=root,credentials=/etc/credential/.smbpassword 0 0
//192.168.0.3/Music    /mnt/Music    cifs uid=root,credentials=/etc/credential/.smbpassword 0 0
//192.168.0.3/Video    /mnt/Video    cifs uid=root,credentials=/etc/credential/.smbpassword 0 0" > /etc/fstab
```
