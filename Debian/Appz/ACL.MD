#### Installation
```
apt install -y acl
```

#### Création d'un dossier
```
clear;
rm -r /root/test 2>/dev/null;
mkdir /root/test 2>/dev/null;
```

#### Lister
```
clear;
getfacl /root/test;
```

#### Editer les droits
###### Editiion des permissions
```
setfacl -R -m g:root:rwx   /root/test;# Groupe root
setfacl -R -m u:root:rwx   /root/test;# Propriétaire
setfacl -R -m o::r-x       /root/test;# Autres
setfacl -R -m g:monftp:--x /root/test;# Groupe monftp
```

####### Définir un ACL par défaut
```
setfacl -R -m d:g:monftp:-   /root/test;
setfacl -R -m d:u:test:r     /root/test;
setfacl -R -m d:o::rwx       /root/test;
```

##### Remise à zéro ACL
```
setfacl -b  /root/test;
```

##### Sauvegarder / Restaure ACL
Il faut se placer dans le répertoire puis mettre le nom directement sans / avant !
```
getfacl -R test > /monfichier.acl
setfacl --restore=/monfichier.acl
```
