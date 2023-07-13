##########
# Schéma #
##########
VMDK > RAW > AUGMENTER > VMDK


########################################
# Script pour agrandir l'espace disque #
########################################

DOSSIER=/mnt/SAMSUNG/DISK/images
VMID_1=101
FORMAT=qcow2

##############################
# Creation du Dossier Backup #
##############################
mkdir $DOSSIER/$VMID_1/Backup 

#################################
# Déplacement de l'image Disque #
#################################
mv $DOSSIER/$VMID_1/vm-$VMID_1-disk-0.$FORMAT $DOSSIER/$VMID/Backup/vm-$VMID_1-disk-0.$FORMAT 
mv $DOSSIER/$VMID_1/vm-$VMID_1-disk-1.$FORMAT $DOSSIER/$VMID/Backup/vm-$VMID_1-disk-1.$FORMAT 
mv $DOSSIER/$VMID_1/vm-$VMID_1-disk-2.$FORMAT $DOSSIER/$VMID/Backup/vm-$VMID_1-disk-2.$FORMAT 


############################
# Convertir l'image en RAW #
############################
qemu-img convert $DOSSIER/$VMID_1/Backup/vm-$VMID_1-disk-0.$FORMAT  $DOSSIER/$VMID_1/vm-$VMID_1-disk-0.raw
qemu-img convert $DOSSIER/$VMID_1/Backup/vm-$VMID_1-disk-1.$FORMAT  $DOSSIER/$VMID_1/vm-$VMID_1-disk-1.raw
qemu-img convert $DOSSIER/$VMID_1/Backup/vm-$VMID_1-disk-1.$FORMAT  $DOSSIER/$VMID_1/vm-$VMID_1-disk-2.raw



################################
# Création du disque avec X Go # 
################################

# Sources : https://blog.adlibre.org/2011/09/25/how-resize-$FORMAT-using-qemu-tools/
#         : https://doc.ubuntu-fr.org/dd
#         : fdisk -l *.raw > Permet de trouver la taille des blocs (bs)


##################################
# Augmentation du disque à 40 Go #
##################################
qemu-img resize /mnt/SAMSUNG/DISK/images/101/vm-$VMID_1-disk-0.raw +10G
qemu-img resize /mnt/SAMSUNG/DISK/images/101/vm-$VMID_1-disk-1.raw +10G
qemu-img resize /mnt/SAMSUNG/DISK/images/101/vm-$VMID_1-disk-2.raw +10G


##############################
# Convertir l'image en Qcow2 #
##############################
qemu-img convert vm-$VMID_1-disk-0_40go.raw vm-$VMID_1-disk-0.$FORMAT

#################
# Supprimer RAW #
#################
rm $DOSSIER/$VMID/*.raw
