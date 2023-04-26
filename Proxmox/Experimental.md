[TOPIC](https://forum.proxmox.com/threads/problem-error-43-on-amd-rx-6700xt.126434/) (En cours)

#### Prérequis:
```
Dongle HDMI sur la sortie Vidéo du GPU
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
echo "blacklist amdgpu"  >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nvidia"  >> /etc/modprobe.d/blacklist.conf;
echo "blacklist radeon"  >> /etc/modprobe.d/blacklist.conf;
```

### Attacher GPU au module VFIO
```bash
echo "options vfio-pci ids=1002:73df,1002:ab28 disable_vga=1"> /etc/modprobe.d/vfio.conf;
update-initramfs -u;
reboot;
```
```
lspci -v;
lspci -n -s 0b:00
```

------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Création de la VM
```
Machine: Q35
Bios: OVMF
OS: Windows 10

Session: (Important)
 - User: marc
 - Pass: admin
```

#### Ouverture Automatique Session [Microsoft](https://learn.microsoft.com/fr-fr/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon)
```
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" /v DevicePasswordLessBuildVersion /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d marc /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d admin /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon  /t REG_SZ /d 1 /f
```

Source:

[lucduke](https://github.com/lucduke/proxmox/blob/main/3-vm-gaming.md)
