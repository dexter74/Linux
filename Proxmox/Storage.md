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

-------------------------------------------------------------------------------------------------------------------------
### Qcow2
