-------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Edition de la taille des Disques, Stockage </p>

-------------------------------------------------------------------------------------------------------------------------
### LVM
##### Augmenter LVS
La valeur `SIZE` est en Go car le terme `G` est mis sur la ligne `lvextend`.
```bash
SIZE=
VG=
LVS=
lvextend -L ${SIZE}G /dev/$VG/$LVS;
resize2fs /dev/$VG/$LVS;
```

##### Diminuer le FileSystem
Il faut que le FileSystem soit inférieur à la taille du LVS.
```bash
SIZE=
VG=
LVS=
resize2fs /dev/mapper/$VG-$LVS ${SIZE}G;
```

##### Réduire LVS
```
SIZE=
VG=
LVS=
lvreduce -L ${SIZE}G -v /dev/mapper/$VG-$LVS
```
-------------------------------------------------------------------------------------------------------------------------
### Qcow2
##### Utilitaire
```bash
apt install -y libguestfs-tools;
``` 

#### Réduire Qcow2
```bash
STORAGE=data/images
VMID=300
DISK=2
FORMAT=qcow2
SIZE=1

# Création:
qemu-img create -f ${FORMAT} -o preallocation=metadata /${STORAGE}/${VMID}/new-vm-${VMID}-disk-${DISK}.${FORMAT} ${SIZE}G;

# Information:
qemu-img info  /${STORAGE}/${VMID}/new-vm-${VMID}-disk-${DISK}.${FORMAT};

# Copier Ancien vers Nouveau:
virt-resize /${STORAGE}/${VMID}/vm-${VMID}-disk-${DISK}.${FORMAT} /${STORAGE}/${VMID}/new-vm-${VMID}-disk-${DISK}.${FORMAT};

# Renommage:
mv /${STORAGE}/${VMID}/vm-${VMID}-disk-${DISK}.${FORMAT} /${STORAGE}/${VMID}/vm-${VMID}-disk-${DISK}.${FORMAT}.old;
mv /${STORAGE}/${VMID}/new-vm-${VMID}-disk-${DISK}.${FORMAT}; /${STORAGE}/${VMID}/vm-${VMID}-disk-${DISK}.${FORMAT};

# Purge de l'ancien Disque: 
# rm  /${STORAGE}/${VMID}/vm-${VMID}-disk-${DISK}.${FORMAT}.old;
