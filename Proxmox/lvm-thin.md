#### Démontage
```bash
lvchange -an /dev/pve/data
```

#### Suppression
```
lvremove /dev/pve/data
```

#### Remonté le FileSystem
```
mount -a
```
