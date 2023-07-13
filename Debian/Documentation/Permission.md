--------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> La gestion des droits sous Linux</p>
--------------------------------------------------------------------------------------------------------------------------------

#### 1. Introduction

Droit Simple:
 - Debian: - rw- r-- r--
 - Ubuntu: - rw-

##### A. Type d'objets
```
Fichier   : - 
Dossier   : D
Liens     : L
```
##### B. Attibuts
```
Lecture   : R
Écriture  : W
Exécution : X
```
##### D. Catégorie
```
User  (u) : Le 1er  bloc concerne le propriétaire définit sur le fichier. 
Group (G) : Le 2nd  bloc concerne le groupe définit sur le fichier.
Autre (O) : Le 3ème bloc concerne les autres Groupes.
```
##### E. Exemple
`-` `rwx`  `r-x` `r--` `l` `marc` `user` `0` `Sept 28 02:13`  `test`
```
> -       : Fichier
> rwx     : Propriétaire  (Lecture, Écriture et Exécution)
> r-x     : Groupe        (Lecture et Exécution)
> r--     : Autre         (Lecture et Exécution)
> marc    : Propriétaire (Utilisateur)
> user    : Groupe (users)
> 0       : Taille

> Dernière Edition
  > Sept  : Mois
  > 28    : Dae
  > 02:13 : Minute
> test    : Nom du fichier
```

--------------------------------------------------------------------------------------------------------------------------------
#### 2. Vérifier les droits 

###### A. Création d'un fichier
```console
touch ~/Documents/test
```

###### B. Afficher les droits
```console
ls -l ~/Documents/test
```

###### C. Tableau Octal
| Read | Write | Execute |
| ---- | ----- | ------- |
|   4  |   2   |    1    |

###### Exemple:

| r-- | 4 + 0 + 0 = 4 |
| --- | ------------- |
| rw- | 4 + 2 + 0 = 6 |
| r-x | 4 + 0 + 1 = 5 |
| rwx | 4 + 2 + 1 = 7 |


**Droit pour accéder à un Dossier**: Execute

--------------------------------------------------------------------------------------------------------------------------------
#### 3. Modifier les droits

##### A. Ajout / enlever au propriétaire le droit de lecture
```console
Permission de base: r--
chmod u+w test => chmod 6XX
chmod u-w test => chmod 4XX
chmod u+w,o+w test => chmod 6XX
```

##### B. Ajout au groupe le droit de lecture
```console
Permission de base: r--
chmod g+w test => chmod X6X (r + w = 4 + 2)
chmod g-w test => chmod X4X (r = 2)
```

##### C. Ajout au Autre le droit de lecture
```console
Permission de base: r--
chmod o+w test => chmod XX6 (r + w = 4 + 2)
chmod o-w test => chmod XX4 (r = 2)
```

##### D. Editer les droits pour tout le monde
```console
Permission de base: r--
chmod -a=rwx test ==> rwx rwx rwx test
```

##### E. Editer les droits multi-actions
```console
Permission de base: r-- r-- r--
chmod u+x g-r o-r test  ==> r-x --- ---
```

--------------------------------------------------------------------------------------------------------------------------------
#### 4. Droits Spéciaux

##### A. SUID (Propriétaire)
`Permet à un utilisateur qui ne peut pas lancer un programme de pouvoir hériter les droits du propriétaire du fichier.` 

##### Fichier /etc/passwd 
```console
ls /etc/passwd 
- rws r-x r-x root root /etc/passwd (Surligné en rouge)
```
Note:
```
Le marqueur S remplace le X d'exécution.
Permet de lancer le binaire avec les droits du propriétaire.
Exemple: Utilisateur marc lance programme /usr/bin/passwd avec les droits du propriétaire root.
```
##### Attribuer l'héritage d'un fichier
```console
chmod u+s test;
chmod u-s test;
chmod 4755 test (Le 4 = S) 
```

<br />

##### B. SGID (Groupe)
`Permet à un utilisateur qui ne peut pas lancer un programme de pouvoir hériter les droits du Groupe du fichier.` 

##### Fichier /etc/passwd 
```console
ls /etc/passwd 
- rw- r-S r-x root root /etc/passwd (Surligné en rouge)
```

**Note:**
```
Le marqueur S remplace le X d'exécution . Permet de lancer le binaire avec les droits du Groupe.
Exemple: Utilisateur marc lance programme /usr/bin/passwd avec les droits du groupe root
```
##### Attribuer l'héritage d'un fichier
```console
chmod g+s test;
chmod g-s test;
chmod 2755 test; #2 = S 
```

**Note**
| 4 | SetUID     | Execute un fichier avec les droits du propriétaire                                                                |
| - | ---------- | ----------------------------------------------------------------------------------------------------------------- |
| 2 | SetGID     | Execution avec les droits du groupe, il permet l'héritage des droits lors de la création de fichiers et dossiers  |
| 1 | Sticky bit | Empeche le fichier d'être supprimer par quelqu'un d'autre que par son propriétaire ou root                        |


--------------------------------------------------------------------------------------------------------------------------------
#### 5. Sticky Bit

Permet de crée un dossier commun, autorisant l'édition par tout le monde, mais empêche la purge du dossier par les autres.

Seule le propriétaire du dossier peut le faire.

```console
chmod 777   Répertoire ==> d rwx rwx rwx
chmod o+t   Répertoire ==> d rwx rwx rwt
chmod o=rwt Répertoire ==> d rwx rwx rwt (A confirmer)
chmod 1755 Répertoire (1 = t)
```

--------------------------------------------------------------------------------------------------------------------------------
#### 6. Changement de Propriétaire 
```console
chown marc           fichier
chown marc:user      fichier
chown marc           répertoire
chown marc:user      répertoire
chown :groupe        répertoire
chown -R marc:user   répertoire
```
