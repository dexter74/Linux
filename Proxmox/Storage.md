**Augmenter LVS**
La valeur `SIZE` est en Go car le terme `G` est mis sur la ligne `lvextend`.
```bash
SIZE=
VG=
LVS=
lvextend -L ${SIZE}G /dev/$VG/$LVS;
resize2fs /dev/$VG/$LVS;
```
