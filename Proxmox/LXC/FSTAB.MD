#### Monter les Partages
```bash
clear;
sudo apt install -y cifs-utils smbclient 1>/dev/null;

mkdir -p /mnt/{Download,Music,Video};
echo "####################################################################################
//192.168.0.3/Download /mnt/Download cifs uid=root,username=marc,password=admin 0 0
//192.168.0.3/Music    /mnt/Music    cifs uid=root,username=marc,password=admin 0 0
//192.168.0.3/Video    /mnt/Video    cifs uid=root,username=marc,password=admin 0 0
####################################################################################" > /etc/fstab;
mount -a
```
