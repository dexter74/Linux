----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Machine Virtuelle avec Carte-Graphique </p>
----------------------------------------------------------------------------------------------------------------------------------------------------------------


#### Optionnel: ([Intel](https://github.com/intel/nemu/wiki/Testing-VFIO-with-GPU))
```
Dongle HDMI sur la sortie Vidéo du GPU.
```

#### Activer IOMMU:
```bash
# modprobe.blacklist=amdgpu
sed -i -e 's/quiet/quiet amd_iommu=on initcall_blacklist=sysfb_init/g' /etc/default/grub;
nano /etc/default/grub;
```

### Activer Modules
```bash
echo "vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd" > /etc/modules;
```

### KVM
```bash
echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/iommu_unsafe_interrupts.conf;
echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf;
```

### Blacklist
```bash
echo "# GPU AMD"               >  /etc/modprobe.d/blacklist.conf;
echo "blacklist ati"           >> /etc/modprobe.d/blacklist.conf;
echo "blacklist amdgpu"        >> /etc/modprobe.d/blacklist.conf;
echo "blacklist radeon"        >> /etc/modprobe.d/blacklist.conf;
echo "blacklist pcieport"      >> /etc/modprobe.d/blacklist.conf;
echo ""                        >> /etc/modprobe.d/blacklist.conf;
echo "# GPU Nvidia"            >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nouveau"       >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nvidia"        >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nvidiafb"      >> /etc/modprobe.d/blacklist.conf;
echo "blacklist snd_hda_intel" >> /etc/modprobe.d/blacklist.conf;
echo ""                        >> /etc/modprobe.d/blacklist.conf;
echo "# Manette Xbox"          >> /etc/modprobe.d/blacklist.conf;
echo "blacklist xpad"          >> /etc/modprobe.d/blacklist.conf;
```

##### BCM4352 802.11ac Wireless Network Adapter
```bash
echo "blacklist wl"            >> /etc/modprobe.d/blacklist.conf;
echo "blacklist bcma"          >> /etc/modprobe.d/blacklist.conf;
```

##### Ryzen 5700G:
```bash
echo "blacklist ccp"           >> /etc/modprobe.d/blacklist.conf;
echo "blacklist xhci_hcd"      >> /etc/modprobe.d/blacklist.conf;
```


### Attacher GPU au module VFIO
```bash
clear;
echo "###########################################################
# Nvidia: GTX 1060
# options vfio-pci ids=10de:1c02,10de:10f1 disable_vga=1
###########################################################
# Nvidia: RTX 3060
# options vfio-pci ids=10de:2503,10de:228e disable_vga=1
###########################################################
# AMD: RX 6700 XT
# options vfio-pci ids=1002:73df,1002:ab28 disable_vga=1
###########################################################
# Broadcom: BCM4352 802.11ac
# options vfio-pci ids=14e4:43b1
###########################################################" > /etc/modprobe.d/vfio.conf;

nano /etc/modprobe.d/vfio.conf;
```

#### Mettre à jour Grub
````bash
update-initramfs -u;
update-grub;
update-grub2;
reboot;
````


#### Check
```
find /sys/kernel/iommu_groups/ -type l;
dmesg | grep "0b\|0c" | less;
lspci -v;
lspci -n -k -s 0b:00;
lspci -n -k -s 0c:00;
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

#### CPU
```
args: -cpu host,host-cache-info=on,-hypervisor,kvm=off
```

#### Wifi
```
06:00.0 0280: 14e4:43b1 (rev 03)
	Subsystem: 1043:85ba
```
