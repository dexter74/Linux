#### Dossier de Sauvegarderm -r /backup/proxmox/etc/*;
```bash
cp /etc/passwd   /backup/proxmox/etc/;
cp /etc/gshadow  /backup/proxmox/etc/;
cp /etc/group    /backup/proxmox/etc/;

cp /etc/pve/datacenter.cfg /backup/proxmox/etc/;
cp /etc/pve/storage.cfg    /backup/proxmox/etc/;
cp /etc/pve/user.cfg       /backup/proxmox/etc/;

cp -r /etc/pve/nodes /backup/proxmox/etc/nodes;
```bash
mkdir -p /backup/proxmox/etc/;
```

#### Sauvegarde de la  configuration
```
rm -r /backup/proxmox/etc/*;
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
```

#### Permission
```
chown -R root:www-data /etc/*.cfg;
chown -R root:www-data /etc/nodes;
```
