#### Packages
```bash
clear;
sudo apt install -y cifs-utils smbclient 1>/dev/null;
```

#### FSTAB
```bash
clear;
mkdir -p /mnt/{Download,Music,Video};
echo "
##################################################################################################################
//192.168.0.3/Download /mnt/Download cifs uid=root,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
//192.168.0.3/Music    /mnt/Music    cifs uid=root,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
//192.168.0.3/Video    /mnt/Video    cifs uid=root,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
##################################################################################################################" > /etc/fstab; mount -a;
df -h /mnt/Download

```
