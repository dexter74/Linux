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


#### Restauration
```bash 
cp -r /backup/proxmox/etc/* /etc/pve/;
cp -r /backup/proxmox/etc/nodes /etc/nodes;

```

#### Permission
```
chown -R root:www-data /etc/*.cfg;
chown -R root:www-data /etc/nodes;
```
