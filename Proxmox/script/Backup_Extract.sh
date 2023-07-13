#####################################
# Script d'extraction de sauvegarde #
#####################################
#
# Etendre PVE:  sudo pvresize /dev/sdX
# \\192.168.1.2\Proxmox\dump
# http://lapt.blogspot.com/2015/04/comment-extraire-les-fichiers-disques.html
# https://www.liberasys.com/wiki/doku.php?id=proxmox-extract-backup:proxmox_extract_backup

###########################
# Declaration de variable #
###########################
DOSSIER_DUMP=/mnt/pve/NAS/dump
DOSSIER_IMAGE=/mnt/pve/NAS/images
VMID=102
LZO=vzdump-qemu-102-2020_10_10-15_30_29.vma.lzo
VMA=vzdump-qemu-102-2020_10_10-15_30_29.vma
RAW_Disk_EFI=disk-drive-efidisk0.raw
RAW_Disk_0=disk-drive-sata0.raw

##########################
# Extraire Lzop vers VMA #
##########################
lzop -d $DOSSIER_DUMP/$LZO ;

##############################
# Suppression du fichier lzo #
##############################
rm  $DOSSIER_DUMP/$LZO ;

##############################
# Création du dossier Images #
##############################
mkdir -p $DOSSIER_IMAGE/$VMID ;

#####################################################
# Déplacement du fichier VMA dans le dossier Images #
#####################################################
mv $DOSSIER_DUMP/$VMA $DOSSIER_IMAGE/$VMID ;

#########################
# Extraire VMA vers RAW #
#########################
vma extract $DOSSIER_IMAGE/$VMID/$VMA $DOSSIER_IMAGE/$VMID/tmp ;

###################
# Suppression VMA #
###################
rm $DOSSIER_IMAGE/$VMID/$VMA ;

#############################
# Copie de la configuration #
#############################
cp $DOSSIER_IMAGE/$VMID/tmp/qemu-server.conf /etc/pve/qemu-server/$VMID.conf ;

###################################
# Remplacement du nom du stockage #
###################################
sed -i -- 's/Disque/NAS/g' /etc/pve/qemu-server/102.conf ;


######################
# Convertir en qcow2 #
######################
qemu-img convert -O qcow2 $DOSSIER_IMAGE/$VMID/tmp/$RAW_Disk_EFI $DOSSIER_IMAGE/$VMID/vm-$VMID-disk-0.qcow2 ; # EFI
qemu-img convert -O qcow2 $DOSSIER_IMAGE/$VMID/tmp/$RAW_Disk_0   $DOSSIER_IMAGE/$VMID/vm-$VMID-disk-1.qcow2 ; # Windows

########################
# Purge du dossier tmp #
########################
rm -r $DOSSIER_IMAGE/$VMID/tmp/
