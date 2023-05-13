###########################################################################
# Auteur du script : Marc Jaffré                                          #
# Date d'édition   : 13-05-2012                                           #
# Version: Alpha 1.0                                                      #
#                                                                         #
# Présentation:                                                           #
# - Script pour l'ajout ou suppression de Disque via un menu de sélection #
#                                                                         #
###########################################################################

# Nettoyage de la console
clear;

# Chargement des fonctions Attach
source ./fonction/attach

# Récupération de l'ID en cours
ID=$(id -u)

# Vérification
if [[ $ID = 0 ]]; then
 MENU=0;
fi

# Boucle Infinie
while [ $MENU = 0 ];
 do
 func_MENU;
 func_CHOIX;
 done
