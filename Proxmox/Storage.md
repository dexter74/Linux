**Augmenter LVS**
```bash
# Définir la Taille du LVS
SIZE=XXXG
VG=
LVS=
lvextend -L $SIZE /dev/$VG/$LVS;
resize2fs /dev/$VG/$LVS;
```
