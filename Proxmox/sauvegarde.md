#### Dossier de Sauvegarde
```bash
mkdir -p /backup/proxmox/etc/;
```



#### Sauvegarde de la  configuration
```
cp /etc/passwd   /backup/proxmox/etc/;
cp /etc/gshadow  /backup/proxmox/etc/;
cp /etc/group    /backup/proxmox/etc/;

cp /etc/pve/datacenter.cfg /backup/proxmox/etc/;
cp /etc/pve/storage.cfg    /backup/proxmox/etc/;
cp /etc/pve/user.cfg       /backup/proxmox/etc/;

cp -r /etc/pve/nodes /backup/proxmox/etc/nodes;
```
