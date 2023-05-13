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
source fonction/attach

# Déclaration d'une variable pour la boucle Infinie
MENU=0

# Boucle Infinie
while [ $MENU = 0 ];
 do
 func_MENU;
 func_CHOIX;
 done
