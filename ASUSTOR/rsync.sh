#############################
# Script de synchronisation #
#############################
clear;

# Déclaration des variables
SOURCE=/share/Video/Series/*
DESTINATION=/share/MyArchive1/Series
OPTION="-arvz --progress --delete-before"

# Sauvegarde (Test)
rsync $OPTION $SOURCE $DESTINATION --dry-run;

# Sauvegarde (Réel)
rsync $OPTION $SOURCE $DESTINATION;

# rm nohup.out; nohup rsync $OPTION $SOURCE $DESTINATION &

# rm myprogram.*; nohup rsync $OPTION $SOURCE $DESTINATION > myprogram.out 2> myprogram.err &
# tail -f myprogram.out;
# tail -f myprogram.err;

# ps | grep -v grep | grep  rsync;

# kill -s TERM $(pidof rsync);
# kill -s TERM $(pgrep rsync);
# kill -s kill $(pidof rsync);

# lsof | grep $DESTINATION;
# fuser -k -TERM $DESTINATION;
# fuser -m -k    $DESTINATION;

#########################################################################################
# -a: Mode archivage
# -g: Préserve le groupe
# -o: Préserve le propriétaire
# -p: Préserve les permissions
# -r: Mode récursive
# -t: Préserve les dates
# -v: Mode Verbose
# -u: Ignorer les fichiers supplémentaires destination
# -z: Mode compression

# --delete-before: Supprime les fichiers absents de la source (Avant la synchronisation)
# --delete: Miroir Parfait (Si fichier absent dans la destination, il sera supprimé)
# --progress: Affiche la barre de progression
# --dry-run: Mode Test
#########################################################################################
