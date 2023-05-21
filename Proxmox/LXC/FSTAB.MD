#### Monter les Partages
```
mkdir -p /mnt/{Download,Music,Video};
echo "###################################################################################
//192.168.0.3/Download /mnt/Download cifs uid=root,username=marc,password=marc 0 0
//192.168.0.3/Music    /mnt/Music    cifs uid=root,username=marc,password=marc 0 0
//192.168.0.3/Video    /mnt/Video    cifs uid=root,username=marc,password=marc 0 0
###################################################################################" > /etc/fstab;
mount -a
```
