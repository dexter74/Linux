**Augmenter LVS**
```bash
# Définir la Taille du LVS
SIZE=XXX
VG=
LVS=
lvextend -L ${SIZE}G /dev/$VG/$LVS;
resize2fs /dev/$VG/$LVS;
```
