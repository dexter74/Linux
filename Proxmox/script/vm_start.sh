################################################
# Script de démarrage des Machines Virtuelles  #
################################################

#Nettoyage de la console
clear


echo "##############################"
echo "### Démarrage de la VM 100 ###"
qm start 100 # Pfsense
echo "##############################"

echo ""

echo "##############################"
echo "### Démarrage de la VM 101 ###"
qm start 101 # WINSRV16
echo "##############################"

echo ""

echo "##############################"
echo "### Démarrage de la VM 102 ###"
qm start 102 #PSTEPACY01
echo "##############################"

echo ""
echo "--- Vérification des VM ---"
echo ""

echo "###########################"
echo "### Status de la VM 100 ###"
qm status 100 # Pfsense
echo "###########################"

echo ""

echo "###########################"
echo "### Status de la VM 101 ###"
qm status 101 # WINSRV16
echo "###########################"

echo ""

echo "###########################"
echo "### Status de la VM 102 ###"
qm status 102 # PSTEPACY0
echo "###########################"

echo ""
