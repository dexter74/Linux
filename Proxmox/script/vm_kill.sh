#####################################################
# Commande pour fermer de manière non propre les VM #
#####################################################
ps -ef | grep '/usr/bin/kvm' | grep -v grep | awk '{print $2}' | xargs -r kill -9
