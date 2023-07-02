----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Machine Virtuelle avec Carte-Graphique </p>
----------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Maintenance
```clear;
nano /etc/modprobe.d/vfio.conf;
nano /etc/modprobe.d/pve-blacklist.conf;
nano /etc/modprobe.d/vfio.conf;
nano /etc/default/grub;
```


### Relever les informations
```
lspci -nn -k | grep "NVIDIA\|3D\|VGA\|Audio" -A3 | grep -v "modules\|Subsystem\|DeviceName\|--";
# 00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 620 [8086:5916] (rev 02)
# Kernel driver in use: i915

# 03:00.0 3D controller [0302]: NVIDIA Corporation GM108M [GeForce 930M] [10de:1346] (rev a2)
# Kernel driver in use: nouveau

# 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD Audio [8086:9d71] (rev 21)


find /sys/kernel/iommu_groups/ -type l | sort -n;
# /sys/kernel/iommu_groups/14/devices/0000:03:00.0
# /sys/kernel/iommu_groups/13/devices/0000:02:00.0

# Autre:
for d in /sys/kernel/iommu_groups/*/devices/*; do n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns "${d##*/}"; done

uname -r;
# 6.2.16-3-pve
```

### Vérifier la présence du Module vfio_virqfd
Le kernel de ma machine est `6.2.16-3` par conséquent le module doit être présent pour lui ce qui est pas le cas.
```
# find /usr/lib/modules -type f -name "vfio*" -o -name "vfio_iommu_type1*" -o -name "vfio_pci*" -o -name "vfio_virqfd*" 2>/dev/null | grep $(uname -r)
/usr/lib/modules/6.2.16-3-pve/kernel/drivers/vfio/pci/vfio-pci-core.ko
/usr/lib/modules/6.2.16-3-pve/kernel/drivers/vfio/pci/vfio-pci.ko
/usr/lib/modules/6.2.16-3-pve/kernel/drivers/vfio/vfio.ko
/usr/lib/modules/6.2.16-3-pve/kernel/drivers/vfio/vfio_iommu_type1.ko
```

#### Activer IOMMU:
```bash
# libata.noacpi=1 : Correctif erreur ACPI
sed -i -e 's/\"quiet\"/\"quiet libata.noacpi=1 intel_iommu=on initcall_blacklist=sysfb_init\"/g' /etc/default/grub;
nano /etc/default/grub;
```

### Activer Modules
Le module `vfio_virqfd` est absent du kernel. (Voir plus haut)
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
echo "# GPU Nvidia"             >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist nouveau"       >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist nvidia"        >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist nvidiafb"      >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist snd_hda_intel" >> /etc/modprobe.d/pve-blacklist.conf;
echo "#"                        >> /etc/modprobe.d/pve-blacklist.conf;
echo "# GPU Intel"              >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist i915"          >> /etc/modprobe.d/pve-blacklist.conf;
echo "#"                        >> /etc/modprobe.d/pve-blacklist.conf;
echo "# Manette Xbox"           >> /etc/modprobe.d/pve-blacklist.conf;
echo "#blacklist xpad"          >> /etc/modprobe.d/pve-blacklist.conf;
nano /etc/modprobe.d/pve-blacklist.conf;
```


### Attacher GPU au module VFIO
Dans l'exemple suivant, plusieurs référence de GPU son présent.
```bash
clear;
echo "###########################################################
# Intel Corporation HD Graphics 620 (Sortie Video)
# options vfio-pci  ids=8086:5916 disable_vga=1
###########################################################
# Nvidia: GeForce 930M
# options vfio-pci ids=10de:1346
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

#### Extraire ROM
```

# Intel
export GPU0='00:02.0'
echo 1 > /sys/bus/pci/devices/0000\:"${GPU0}"/rom
cat /sys/bus/pci/devices/0000\:"${GPU0}"/rom > /usr/share/kvm/gpu-"$(date +%Y%m%dT%H%m%S)".rom
echo 0 > /sys/bus/pci/devices/0000\:"${GPU0}"/rom

# Nvidia
export GPU1='03:00.0'
echo 1 > /sys/bus/pci/devices/0000\:"${GPU1}"/rom
cat /sys/bus/pci/devices/0000\:"${GPU1}"/rom > /usr/share/kvm/gpu-"$(date +%Y%m%dT%H%m%S)".rom
echo 0 > /sys/bus/pci/devices/0000\:"${GPU1}"/rom
```
