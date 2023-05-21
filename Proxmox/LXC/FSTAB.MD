#### Monter les Partages
```
echo "//192.168.0.3/Download /mnt/Download cifs uid=root,credentials=/etc/credential/.smbpassword 0 0
//192.168.0.3/Music    /mnt/Music    cifs uid=root,credentials=/etc/credential/.smbpassword 0 0
//192.168.0.3/Video    /mnt/Video    cifs uid=root,credentials=/etc/credential/.smbpassword 0 0" > /etc/fstab
```
