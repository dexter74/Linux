----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Machine Virtuelle avec Carte-Graphique </p>
----------------------------------------------------------------------------------------------------------------------------------------------------------------

#### BIOS:
```
Adresse 4G: OFF
```

#### Maintenance
```
nano /etc/modprobe.d/vfio.conf;
```
```
nano /etc/modprobe.d/pve-blacklist.conf;
```


#### Optionnel: ([Intel](https://github.com/intel/nemu/wiki/Testing-VFIO-with-GPU))
```
Dongle HDMI sur la sortie Vidéo du GPU.
```

### Relever les informations
```
lspci -nn -k | grep "VGA\|3D" -A3 | grep -v modules
# 0b:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 22 [1002:73df] (rev c1)
# Kernel driver in use: amdgpu

lspci -s 0b: -k -nn | grep -i "audio\|vga\|3D" -A2 | grep -iv "sub\|--"
# 0b:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 22 [1002:73df] (rev c1)
# Kernel driver in use: amdgpu
# 0b:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:ab28]
# Kernel driver in use: amdgpu

find /sys/kernel/iommu_groups/ -type l;
# /sys/kernel/iommu_groups/25/devices/0000:0b:00.0
# /sys/kernel/iommu_groups/26/devices/0000:0b:00.1

find /sys/kernel/iommu_groups/ -type l | grep "25\|26";
# /sys/kernel/iommu_groups/25/devices/0000:0b:00.0
# /sys/kernel/iommu_groups/26/devices/0000:0b:00.1

uname -r
# 6.2.9-1-pve
```

### Vérifier la présence du Module vfio_virqfd
Le kernel de ma machine est `6.2.9.1` par conséquent le module doit être présent pour lui ce qui est pas le cas.
```
# find /usr/lib/modules -type f -name "vfio*" -o -name "vfio_iommu_type1*" -o -name "vfio_pci*" -o -name "vfio_virqfd*" 2>/dev/null | grep $(uname -r)
/usr/lib/modules/6.2.9-1-pve/kernel/drivers/vfio/vfio_iommu_type1.ko
/usr/lib/modules/6.2.9-1-pve/kernel/drivers/vfio/pci/vfio-pci.ko
/usr/lib/modules/6.2.9-1-pve/kernel/drivers/vfio/pci/vfio-pci-core.ko
/usr/lib/modules/6.2.9-1-pve/kernel/drivers/vfio/vfio.ko
```


#### Activer IOMMU:
```bash
# modprobe.blacklist=amdgpu
# intel_iommu=on libata.noacpi=1 pour la machine vm65n
sed -i -e 's/quiet/quiet amd_iommu=on initcall_blacklist=sysfb_init/g' /etc/default/grub;
nano /etc/default/grub;
```


### Activer Modules
Le module `vfio_virqfd` est absent du `kernel 6.2.9-1`. (Voir plus haut)
```bash
echo "vfio
vfio_iommu_type1
vfio_pci" > /etc/modules;
```

### KVM
```bash
echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/iommu_unsafe_interrupts.conf;
echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf;
```

### Blacklist
Le Blacklistage permet d'interdire les pilotes à se charger à son lancement. (Liste non exhaustive)

Dans mon cas le GPU utilise `AMDGPU`.
```bash
echo "# GPU AMD"                >  /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist ati"           >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist amdgpu"        >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist radeon"        >> /etc/modprobe.d/pve-blacklist.conf;
echo "#"                        >> /etc/modprobe.d/pve-blacklist.conf;
echo "# GPU Nvidia"             >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist nouveau"       >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist nvidia"        >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist nvidiafb"      >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist snd_hda_intel" >> /etc/modprobe.d/pve-blacklist.conf;
echo "#"                        >> /etc/modprobe.d/pve-blacklist.conf;
echo "# Manette Xbox"           >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist xpad"          >> /etc/modprobe.d/pve-blacklist.conf;
```

##### BCM4352 802.11ac Wireless Network Adapter
```bash
echo "#"                        >> /etc/modprobe.d/pve-blacklist.conf;
echo "# BCM4352"                >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist wl"            >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist bcma"          >> /etc/modprobe.d/pve-blacklist.conf;
```

##### Ryzen 5700G:
```bash
echo "#"                        >> /etc/modprobe.d/pve-blacklist.conf;
echo "# Ryzen 5700g"            >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist ccp"           >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist xhci_hcd"      >> /etc/modprobe.d/pve-blacklist.conf;
```

### Attacher GPU au module VFIO
Dans l'exemple suivant, plusieurs référence de GPU son présent.
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
options vfio-pci ids=1002:73df,1002:ab28 disable_vga=1
###########################################################
# Broadcom: BCM4352 802.11ac
# options vfio-pci ids=14e4:43b1
###########################################################" > /etc/modprobe.d/vfio.conf;

nano /etc/modprobe.d/vfio.conf;
```

#### Mettre à jour Grub
Grub qui est le gestionnaire de démarrage, les commandes suivantes permettent de mettre à jour le démarrage.
````bash
update-initramfs -u;
update-grub;
update-grub2;
reboot;
````


#### Vérification du bon fonctionnement
On peut voir que ma Carte-graphique à comme pilote VFIO-PCI ce qui indique qu'elle est bien attribuer au Module et donc elle est disponible à l'attribution dans une VM .
```
find /sys/kernel/iommu_groups/ -type l;
dmesg | grep "0b" | less;
lspci -v;
lspci -n -k -s 0b:00;

# 0b:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 22 [1002:73df] (rev c1)
# Kernel driver in use: vfio-pci
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
# nano /etc/pve/qemu-server/XXX.conf;
args: 
 -cpu host,host-cache-info=on
 -hypervisor,kvm=off
```

#### Wifi
```
06:00.0 0280: 14e4:43b1 (rev 03)
	Subsystem: 1043:85ba
```
