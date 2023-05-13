#### Attacher Disque-Dur physique à une VM
Une fois Ajouter, il faut éditer le Disque pour empêcher la sauvegarde de celui-ci.
```
clear;
VM=310
SATA=sata1
DISK=/dev/sdc

qm shutdown ${VM};
qm unlink ${VM} --idlist ${SATA};
qm set ${VM} -${SATA} ${DISK};
qm start ${VM};
```
