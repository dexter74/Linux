----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Machine Virtuelle avec Carte-Graphique </p>
----------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Maintenance
```
nano /etc/modprobe.d/vfio.conf;
```
```
nano /etc/modprobe.d/pve-blacklist.conf;
```


### Relever les informations
```
lspci -nn -k | grep "NVIDIA" -A3 | grep -v modules
03:00.0 3D controller [0302]: NVIDIA Corporation GM108M [GeForce 930M] [10de:1346] (rev a2)
	Subsystem: ASUSTeK Computer Inc. GM108M [GeForce 930M] [1043:86b8]
	Kernel driver in use: nouveau


lspci -s 03: -k -nn | grep -i "audio\|vga\|3D" -A2 | grep -iv "sub\|--"

# 03:00.0 3D controller [0302]: NVIDIA Corporation GM108M [GeForce 930M] [10de:1346] (rev a2)
#	Kernel driver in use: nouveau

find /sys/kernel/iommu_groups/ -type l | sort -n;
# sys/kernel/iommu_groups/14/devices/0000:03:00.0

uname -r
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
# modprobe.blacklist=amdgpu
# intel_iommu=on libata.noacpi=1 pour la machine vm65n
sed -i -e 's/\"quiet\"/\"quiet intel_iommu=on libata.noacpi=1 initcall_blacklist=sysfb_init\"/g' /etc/default/grub;
nano /etc/default/grub;
```
