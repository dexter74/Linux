#!/bin/bash

#################################################################################################
#                   SCRIPT DE diminution de l'espace Disque QCOW2                               #
#                                                                                               #
# Auteur            : JAFFRE MARC (Technicien Helpdesk)                                         #
# Présentation      : Script crée pour diminuer le volume d'un disque                           #
# Version           : 1.0                                                                       #
# Date d'édition    : 26-08-2019                                                                #
# ############################################################################################# #
#                                                                                               #
# Inspirer par les sources suivantes                                                            #
# - https://forum.proxmox.com/threads/how-to-shrink-decrease-qcow2-size-of-vm-in-pve-4-1.26545/ #
# - http://c-nergy.be/blog/?p=1323                                                              #
# sata2: DISQUE:101/vm-101-disk-2.qcow2,cache=writeback,size=1700G,ssd=1                        #
#                                                                                               #
# 1700 Go = 1740800 Bytes                                                                       #
# 1000 Go = 1024000 Bytes                                                                       #
# 1740800 - 1024000 = 716800 Bytes                                                              #
#                                                                                               #
# Windows > Gestion du DISQUE > Diminuer le volume > 716800 Bytes                               #
#                                                                                               #
#################################################################################################


#################################################################################################
# Guide D'utilisation: Chaque étape se déroule sur des steps                                    #
#                                                                                               #
#   - Allumer La VM                                                                             #
#     > Diminuer le Volume (1,7 To à 1 To par exemple)                                          #
#                                                                                               #
#   - Eteindre la VM                                                                            #
#                                                                                               #
#   > Modifier les variables:                                                                   #
#     - VMID correspond au NUMERO DE LA VM                                                      #
#     - NUMERO_DISK correspond au NUMERO DU DISQUE                                              #
#     - SPACE_DISK Définit la taille du volulme                                                 #
#                                                                                               #
#   - Exécution du script                                                                       #
#                                                                                               #
#   - Modifier la configuration de la VM (/etc/pve/nodes/<Name_node>/qemu-server/)              #
#                                                                                               #
#   - Supprimer le dossier Backup                                                               #
#                                                                                               #
#################################################################################################


###########################
# Nettoyage de la console #
###########################
clear

####################
# Fermeture des VM #
####################
ps -ef | grep '/usr/bin/kvm' | grep -v grep | awk '{print $2}' | xargs -r kill -9

#############################
# DÉCLARATION DES VARIABLES #
#############################
#sata1: DISQUE:103/vm-103-disk-1.qcow2,size=300G,ssd=1

#Dossier contenant le DISQUE
DOSSIER=/mnt/SAMSUNG/DISK/images

#Numéro de la Machine Virtuelle 
VMID=103

#Numéro du disque
NUMERO_DISK=1

#Nom de fichier a traité
DISK_QSCOW=vm-$VMID-disk-$NUMERO_DISK.qcow2
DISK_RAW=vm-$VMID-disk-$NUMERO_DISK.raw

#Définir la taille du Disque-dur (Windows: Gestion du disque | Unix: GParted - Valeur en Giga)
SPACE_DISK=50



##########################
# DEBUT DE LA CONVERSION #
##########################

###############################################
# Step 0A: Se situer dans le dossier de la VM #
###############################################
cd "$DOSSIER/$VMID"

#######################################
# Step 0B: Creation du dossier Backup #
#######################################
mkdir $DOSSIER/$VMID/Backup

#############################################################
# Step 1A: Déplacement du disque dans le dossier Sauvegarde #
#############################################################
mv $DOSSIER/$VMID/$DISK_QSCOW $DOSSIER/$VMID/Backup/$DISK_QSCOW

###################################################################
# Step 1B: SUPPRESSION Du DISK PRESENT dans le dossier de la VMID #
###################################################################
#rm $DOSSIER/$VMID/$DISK_QSCOW
rm $DOSSIER/$VMID/$DISK_RAW

###################################
# Step 2A: Conversion QCOW2 > RAW #
###################################
qemu-img convert $DOSSIER/$VMID/Backup/$DISK_QSCOW $DOSSIER/$VMID/$DISK_RAW 

############################################
# Step 2B: REDIMENSIONNEMENT du disque RAW #
############################################
qemu-img resize -f raw $DOSSIER/$VMID/$DISK_RAW --shrink "$SPACE_DISK"g

###################################
# Step 2C: Conversion RAW > QCOW2 #
###################################
qemu-img convert -O qcow2 $DOSSIER/$VMID/$DISK_RAW $DOSSIER/$VMID/Backup/$DISK_QSCOW

######################################
# Step 3C: Suppression du disque RAW #
######################################
rm ./$DISK_RAW

########################
# FIN DE LA CONVERSION #
########################

##############
# PENSE BETE #
##############

#Edition du fichier config
echo "/bin/nano /etc/pve/nodes/proxmox/qemu-server/$VMID.conf ($SPACE_DISK)"
echo "qm start $VMID "
echo "qm status $VMID"
echo "rm -r $DOSSIER/$VMID/Backup"
echo "cd /root/"

# qemu-img info ./Backup/$DISK_QSCOW
# qemu-img info ./$DISK_QSCOW
# qemu-img info ./$DISK_RAW
