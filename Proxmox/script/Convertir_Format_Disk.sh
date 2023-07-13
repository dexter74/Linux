#!/bin/bash

#################################################################
# Script            : Converties les Machines Virtuelles        #
# Date de révision  : 26-09-2019                                #
# Version           : 0.1                                       #
# Status            : Fonctionnel                               #
#                                                               #
# Auteur            : Marc Jaffré                               #
# Email             : mje2017.afpa[at]gmail.com                 #
#                                                               #
#                                                               #
# Variables:                                                    #
#           - SOURCE: Format en entrée de votre Disque          #
#           - SORTIE: Format de sortie de votre Disque          #
#                                                               #
#                                                               #
# Source: https://blog.lbdg.me/proxmox-convert-vmdk-to-qcow2    #
#################################################################


# wget https://raw.githubusercontent.com/dexter74/Linux-Shell-by-Drthrax/master/Proxmox/script/Convertir_VM.sh -O /root/Convertir_VM.sh 

#Commande : qemu-img convert -f  qcow2 <MONIMAGE.qcow2> -O vmdk <MONIMAGE.vmdk>
#           qemu-img convert -f vmdk openmanage_enterprise.x86_64-0.0.1-disk1.vmdk -O qcow2 OpenManageEntreprise-3-1.qcow2

#############
# Variables #
#############

#Dossier contenant les VM
DOSSIER=/mnt/SAMSUNG/DISK/images

SOURCE=vmdk
SORTIE=qcow2

#Numéro de la VM a convertir
VM_0=100
VM_1=101
VM_2=102
VM_3=103
VM_4=104
VM_5=105
VM_500=500
VM_501=501
VM_502=502
VM_503=503
VM_504=504
VM_505=505


#Numéro du disque à convertir
DISK_0=0
DISK_1=1
DISK_2=2


###########################
# Disk VM: vm-VMID-X.vmdk #
###########################


########
# VM 0 #
########
qemu-img convert -f $SOURCE $DOSSIER/$VM_0/vm-$VM_0-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_0/vm-$VM_0-disk-$DISK_0.qcow2 && echo "VM $VM_0 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_0/vm-$VM_0-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_0/vm-$VM_0-disk-$DISK_1.qcow2 && echo "VM $VM_0 - Disk $DISK_2"
qemu-img convert -f $SOURCE $DOSSIER/$VM_0/vm-$VM_0-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_0/vm-$VM_0-disk-$DISK_2.qcow2 && echo "VM $VM_0 - Disk $DISK_3"


########
# VM 1 #
########

qemu-img convert -f $SOURCE $DOSSIER/$VM_1/vm-$VM_1-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_1/vm-$VM_1-disk-$DISK_0.qcow2 && echo "VM $VM_1 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_1/vm-$VM_1-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_1/vm-$VM_1-disk-$DISK_1.qcow2 && echo "VM $VM_1 - Disk $DISK_2"
qemu-img convert -f $SOURCE $DOSSIER/$VM_1/vm-$VM_1-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_1/vm-$VM_1-disk-$DISK_2.qcow2 && echo "VM $VM_1 - Disk $DISK_3"


########
# VM 2 #
########

echo "VM $VM_2"
qemu-img convert -f $SOURCE $DOSSIER/$VM_2/vm-$VM_2-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_2/vm-$VM_2-disk-$DISK_0.qcow2 && echo "VM $VM_2 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_2/vm-$VM_2-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_2/vm-$VM_2-disk-$DISK_1.qcow2 && echo "VM $VM_2 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_2/vm-$VM_2-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_2/vm-$VM_2-disk-$DISK_2.qcow2 && echo "VM $VM_2 - Disk $DISK_3"


########
# VM 3 #
########

echo "VM $VM_3"
qemu-img convert -f $SOURCE $DOSSIER/$VM_3/vm-$VM_3-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_3/vm-$VM_3-disk-$DISK_0.qcow2 && echo "VM $VM_3 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_3/vm-$VM_3-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_3/vm-$VM_3-disk-$DISK_1.qcow2 && echo "VM $VM_3 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_3/vm-$VM_3-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_3/vm-$VM_3-disk-$DISK_2.qcow2 && echo "VM $VM_3 - Disk $DISK_3"


########
# VM 4 #
########

echo "VM $VM_4"
qemu-img convert -f $SOURCE $DOSSIER/$VM_4/vm-$VM_4-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_4/vm-$VM_4-disk-$DISK_0.qcow2 && echo "VM $VM_4 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_4/vm-$VM_4-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_4/vm-$VM_4-disk-$DISK_1.qcow2 && echo "VM $VM_4 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_4/vm-$VM_4-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_4/vm-$VM_4-disk-$DISK_2.qcow2 && echo "VM $VM_4 - Disk $DISK_3"


########
# VM 5 #
########

echo "VM $VM_5"
qemu-img convert -f $SOURCE $DOSSIER/$VM_5/vm-$VM_5-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_5/vm-$VM_5-disk-$DISK_0.qcow2 && echo "VM $VM_5 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_5/vm-$VM_5-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_5/vm-$VM_5-disk-$DISK_1.qcow2 && echo "VM $VM_5 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_5/vm-$VM_5-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_5/vm-$VM_5-disk-$DISK_2.qcow2 && echo "VM $VM_5 - Disk $DISK_3"


##########
# VM 503 #
##########

echo "VM $VM_503"
qemu-img convert -f $SOURCE $DOSSIER/$VM_503/vm-$VM_503-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_503/vm-$VM_503-disk-$DISK_0.qcow2 && echo "VM $VM_503 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_503/vm-$VM_503-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_503/vm-$VM_503-disk-$DISK_1.qcow2 && echo "VM $VM_503 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_503/vm-$VM_503-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_503/vm-$VM_503-disk-$DISK_2.qcow2 && echo "VM $VM_503 - Disk $DISK_3"



################################
# Templates : base-VMID-X.vmdk #
################################







##########
# VM 500 #
##########

echo "VM $VM_500"
qemu-img convert -f $SOURCE $DOSSIER/$VM_500/base-$VM_500-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_500/base-$VM_500-disk-$DISK_0.qcow2 && echo "VM $VM_500 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_500/base-$VM_500-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_500/base-$VM_500-disk-$DISK_1.qcow2 && echo "VM $VM_500 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_500/base-$VM_500-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_500/base-$VM_500-disk-$DISK_2.qcow2 && echo "VM $VM_500 - Disk $DISK_3"


##########
# VM 501 #
##########

echo "VM $VM_501"
qemu-img convert -f $SOURCE $DOSSIER/$VM_501/base-$VM_501-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_501/base-$VM_501-disk-$DISK_0.qcow2 && echo "VM $VM_501 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_501/base-$VM_501-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_501/base-$VM_501-disk-$DISK_1.qcow2 && echo "VM $VM_501 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_501/base-$VM_501-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_501/base-$VM_501-disk-$DISK_2.qcow2 && echo "VM $VM_501 - Disk $DISK_3"


##########
# VM 502 #
##########

echo "VM $VM_502"
qemu-img convert -f $SOURCE $DOSSIER/$VM_502/base-$VM_502-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_502/base-$VM_502-disk-$DISK_0.qcow2 && echo "VM $VM_502 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_502/base-$VM_502-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_502/base-$VM_502-disk-$DISK_1.qcow2 && echo "VM $VM_502 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_502/base-$VM_502-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_502/base-$VM_502-disk-$DISK_2.qcow2 && echo "VM $VM_502 - Disk $DISK_3"


##########
# VM 504 #
##########

echo "VM $VM_504"
qemu-img convert -f $SOURCE $DOSSIER/$VM_504/base-$VM_504-disk-$DISK_0.vmdk -O $SORTIE $DOSSIER/$VM_504/base-$VM_504-disk-$DISK_0.qcow2 && echo "VM $VM_504 - Disk $DISK_1"
qemu-img convert -f $SOURCE $DOSSIER/$VM_504/base-$VM_504-disk-$DISK_1.vmdk -O $SORTIE $DOSSIER/$VM_504/base-$VM_504-disk-$DISK_1.qcow2 && echo "VM $VM_504 - Disk $DISK_2" 
qemu-img convert -f $SOURCE $DOSSIER/$VM_504/base-$VM_504-disk-$DISK_2.vmdk -O $SORTIE $DOSSIER/$VM_504/base-$VM_504-disk-$DISK_2.qcow2 && echo "VM $VM_504 - Disk $DISK_3"


#qemu-img info $DOSSIER/.....

#########################################################
# Modifier le fichier configuration de la VM            #
# Supprimer l'ancien format de la VM après vérification #
#########################################################

