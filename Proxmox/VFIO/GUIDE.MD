----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Mise en place d'une Machine Virtuelle sous Proxmox disposant d'un GPU dédiée </p>
----------------------------------------------------------------------------------------------------------------------------------------------------------------


#### Optionnel: ([Intel](https://github.com/intel/nemu/wiki/Testing-VFIO-with-GPU))
```
Dongle HDMI sur la sortie Vidéo du GPU.
```

#### Activer IOMMU:
```bash
sed -i -e 's/quiet/quiet amd_iommu=on initcall_blacklist=sysfb_init/g' /etc/default/grub;
nano /etc/default/grub;
update-grub;
```

### Activer Modules
```bash
echo "vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd" > /etc/modules
```

### KVM
```bash
echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/iommu_unsafe_interrupts.conf;
echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf;
```

### Blacklist
```bash
echo "blacklist amdgpu"         > /etc/modprobe.d/blacklist.conf;
echo "blacklist nouveau"       >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nvidia"        >> /etc/modprobe.d/blacklist.conf;
echo "blacklist radeon"        >> /etc/modprobe.d/blacklist.conf;
echo "blacklist snd_hda_intel" >> /etc/modprobe.d/blacklist.conf;
```

##### Ryzen 5700G:
```bash
echo "blacklist ccp"           >> /etc/modprobe.d/blacklist.conf;
echo "blacklist xhci_hcd"      >> /etc/modprobe.d/blacklist.conf;
```


### Attacher GPU au module VFIO
```bash
echo "# AMD: RX 6700 XT
options vfio-pci ids=1002:73df,1002:ab28 disable_vga=1

# Nvidia: GTX 1060
options vfio-pci ids=10de:1c02,10de:10f1 disable_vga=1"> /etc/modprobe.d/vfio.conf;
update-initramfs -u;
reboot;
```

#### Check
```
find /sys/kernel/iommu_groups/ -type l;
dmesg | grep "0b\|0c";
lspci -v;
lspci -n -s 0b:00;
lspci -n -s 0c:00;
```

------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Création de la VM
```
Machine: Q35
Bios: OVMF
OS: Windows 10

Display: none (optionnel)
PCI device: 0000:0b:00.0
  - ROM Bar: Cocher
  - PCI-Express: Cocher


Session: (Important)
 - User: marc
 - Pass: admin
```

#### Attacher Disque-Dur physique à une VM
Une fois Ajouter, il faut éditer le Disque pour empêcher la sauvegarde de celui-ci.
```
qm set 310 -sata2 /dev/nvme0n1p1;
qm unlink 310 --idlist sata2;
```

#### Ouverture Automatique Session ([Microsoft](https://learn.microsoft.com/fr-fr/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon))
```
set USER=marc
set PASS=admin
set ETAT=1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" /v DevicePasswordLessBuildVersion /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d %USER% /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d %PASS% /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon  /t REG_SZ /d %ETAT% /f
```

Source:
[lucduke](https://github.com/lucduke/proxmox/blob/main/3-vm-gaming.md)
