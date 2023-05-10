**Augmenter LVS**
```
# Définir la Taille du LVS
SIZE=700G
lvextend -L $SIZE /dev/vg0/Data;
resize2fs /dev/vg0/Data;
```
