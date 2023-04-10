##### Coffre-fort
```bash
pacman -Sy --noconfirm seahorse;
```

------------------------------------------------------------------------------------------------------------------
##### Lecteur Multimédias
```bash
pacman -Sy --noconfirm smplayer;
pacman -Sy --noconfirm mplayer;
```

##### Lecteur Musique
```bash
yay -Sy --noconfirm rhythmbox;
yay -Sy --noconfirm rhythmbox-plugin-hide-git;
yay -Sy --noconfirm rhythmbox-plugin-tray-icon;
yay -Sy --noconfirm rhythmbox-tray-icon;
yay -Sy --noconfirm papirus-smplayer-theme-git;
```

##### Configurer Smplayer
```
Préférences > Options
  > Général:
   - Moteur Multimédia: mplayer (mpv: BUG !)
  > Performance:
   - Thread: 4
   - Décodage matériel: Auto
   - Filtre Anti-bloc: Passer Toujours (CPU ne prend pas en chjarge H.264)
  > Interface
   - GUI   : Interface Mpc 
   - Icône : Papirus
  > Liste de Lecture
   - Commencer à lire après le chargement d'une liste de lecture ==> Décoché
   - Ajouter des fichiers du répertoire: Fichiers Vidéos
   - Ajouter les fichiers des répertoires récursivement
  > Avancés
   - Format de l'écran: 16:9
-----------------------
La liste de lecture:
Clique droit dans le blanc > Décocher les cases
```

<br />

------------------------------------------------------------------------------------------------------------------
##### Navigateurs
```bash
yay -Sy --noconfirm microsoft-edge-stable-bin;
```

------------------------------------------------------------------------------------------------------------------
##### Gestionnaire de Disque-dur
```bash
yay -Sy --noconfirm blivet-gui;
yay -Sy --noconfirm gnome-disk-utility;
```


------------------------------------------------------------------------------------------------------------------
##### Editer profil
```bash
yay -Sy --noconfirm mugshot;
```
