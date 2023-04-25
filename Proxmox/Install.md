#### Création d'un compte Utilisateur Linux
```bash

#########################################################################################################
# Nettoyage de la console #
###########################
clear;

#########################################################################################################
# Déclaration des variables #
#############################
# Nom d'utilisateur et mot de passe du compte:
export UTILISATEUR=Drthrax74
export PASSWORD=admin
export USERID=1000

#########################################################################################################
# Création du compte #
######################
/usr/sbin/useradd \
--home-dir /home/$UTILISATEUR \
--base-dir /home/$UTILISATEUR \
--uid $USERID \
--no-user-group \
--shell /bin/bash \
--create-home $UTILISATEUR;

#########################################################################################################
# Définir le mot de passe du compte #
#####################################
(echo "$UTILISATEUR:$PASSWORD") | chpasswd;

#########################################################################################################
# Sudoers son utilisateur #
###########################
# echo "$UTILISATEUR ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$UTILISATEUR;

#########################################################################################################
# Vérification #
################
id $UTILISATEUR;
```

<br />

------------------------------------------------------------------------------------------

#### Création d'un compte Utilisateur Proxmox
```bash
UTILISATEUR="Drthrax74@pam"
MOTDEPASSE="admin"
EMAIL="teste74@hotmail.fr"
PRENOM="Marc"
NOM="Jaffre"

# Purge
sudo pveum group del   Administrateurs 2>/dev/null;
sudo pveum group del   Audit 2>/dev/null;
sudo pveum group del   Stockage 2>/dev/null;
sudo pveum group del   Utilisateurs 2>/dev/null;
sudo pveum group del   VMadmin  2>/dev/null;
sudo pveum pool del     100.LXC;
sudo pveum pool del     200.Linux;
sudo pveum pool del     300.Windows;
sudo pveum pool del     400.Templates;
sudo pveum user delete $UTILISATEUR 2>/dev/null;

# Création des Groupes:
sudo pveum group add Administrateurs -comment "Groupe des administrateurs"
sudo pveum group add Audit           -comment "Groupe des auditeurs"
sudo pveum group add Stockage        -comment "Groupe du stockage"
sudo pveum group add Utilisateurs    -comment "Groupe des utilisateurs"
sudo pveum group add VMadmin         -comment "Groupe des Admins des VM"

# Création des Pools:
sudo pveum pool add 100.LXC;
sudo pveum pool add 200.Linux;
sudo pveum pool add 300.Windows;
sudo pveum pool add  400.Templates;
# Création Utilisateur
sudo pveum user add "$UTILISATEUR" -email "$EMAIL" -enable 1 -first "$PRENOM" -lastname "$NOM";

# Changement du mot de passe:
(echo "$MOTDEPASSE"; echo "$MOTDEPASSE") | sudo pveum passwd $UTILISATEUR

# Modification des permissions pour les groupes
sudo pveum acl modify / -group Administrateurs -role Administrator;
sudo pveum acl modify / -group Audit -role PVEAuditor;
sudo pveum acl modify / -group Stockage -role PVEDatastoreAdmin;
sudo pveum acl modify / -group Utilisateurs -role PVEVMUser;
sudo pveum acl modify / -group VMadmin -role PVEVMAdmin;

# Modification permission de l'utilisateur
sudo pveum user modify "$UTILISATEUR" -group Administrateurs;
```

#### VFIO
```
# Activer IOMMU:
sed -i -e 's/quiet/quiet amd_iommu=on/g' /etc/default/grub;
update-grub;

# Activer Modules
echo "vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
amd_iommu=on" > /etc/modules


echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/iommu_unsafe_interrupts.conf;
echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf;

echo "blacklist amdgpu"  >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf;
echo "blacklist nvidia"  >> /etc/modprobe.d/blacklist.conf;
echo "blacklist radeon"  >> /etc/modprobe.d/blacklist.conf;


lspci -v;
lspci -n -s 0b:00
echo "options vfio-pci ids=1002:73df,1002:ab28 disable_vga=1"> /etc/modprobe.d/vfio.conf;
update-initramfs -u;
reset;
```
