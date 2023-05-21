#### Packages
```bash
clear;
sudo apt install -y cifs-utils smbclient 1>/dev/null;
```

#### FSTAB
```bash
clear;
mkdir -p /mnt/{Download,Music,Video} 2>/dev/null;
umount -R /mnt/*;
echo "##########################################################################################################################
//192.168.0.3/Download /mnt/Download cifs uid=root,gid=sudo,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
//192.168.0.3/Music    /mnt/Music    cifs uid=root,gid=sudo,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
//192.168.0.3/Video    /mnt/Video    cifs uid=root,gid=sudo,file_mode=0775,dir_mode=0775,username=marc,password=admin 0 0
##########################################################################################################################" > /etc/fstab; mount -a;
df -h /mnt/Download /mnt/Music /mnt/Video 
```
