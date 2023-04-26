################################
# Changer le mot de passe root #
################################
````
Définir le MDP ROOT : (echo XXXX; echo XXXX) | passwd root
Désactiver MDP ROOT : sudo passwd -l root
````

##########################
# Configurer la clé SSH  #
##########################
````
clear;
rm -r .ssh;
mkdir .ssh;
touch .ssh/authorized_keys;
chmod 700 .ssh;
chmod 600 .ssh/authorized_keys;
KEY_SSH_WINDOWS='';
echo $KEY_SSH_WINDOWS > .ssh/authorized_keys;
cat .ssh/authorized_keys;
````


#####################
# Configurer le SSH #
#####################
````
# Sauvegarde             : cp /usr/etc/ssh/sshd_config /usr/etc/ssh/sshd_config.old ;
# Restauration           : cp /usr/etc/ssh/sshd_config.old /usr/etc/ssh/sshd_config ;
# Edition du fichier     : nano /usr/etc/ssh/sshd_config;
# PermitRootLogin        : without-password
# RSAAuthentication      : yes
# PubkeyAuthentication   : yes
# AuthorizedKeysFile     : %h/.ssh/authorized_keys
# PasswordAuthentication : YES # !!!!!!!!!! (Ne pas bloquer avant vérifier)
````
