### Administration
##### Coffre-fort
```bash
sudo pacman -Sy --noconfirm seahorse;
```
##### Editeur de profil
```bash
yay -Sy --noconfirm mugshot;
```
##### Gestionnaire de Disque-dur
```bash
yay -Sy --noconfirm blivet-gui;
yay -Sy --noconfirm gnome-disk-utility;
```
##### Gestionnaire de fichier compréssé
```bash
sudo pacman -Sy --noconfirm file-roller;
```
##### Gestionnaire de Tâches
```bash
yay -Sy --noconfirm sysmontask;
```

##### Pavé-Numérique
```bash
sudo pacman -Sy --noconfirm numlockx;
```
##### Magasin Applicatif (KO)
```bash
yay -Sy --noconfirm pamac-all;
```
##### Sauvegarde et Restauration
```bash
yay -Sy --noconfirm timeshift;
```
##### Virtualbox
```
sudo pacman -Sy --noconfirm virtualbox virtualbox-guest-iso virtualbox-host-modules-arch;
yay    -Sy --noconfirm virtualbox-ext-oracle;

echo "* 192.168.1.0/24
* 192.168.2.0/24
* 192.168.3.0/24
* 192.168.4.0/24
* 192.168.5.0/24" > /etc/vbox/networks.conf;
```

------------------------------------------------------------------------------------------------------------------
### Multimédias
##### Lecteur de Film
```bash
sudo pacman -Sy --noconfirm smplayer;
sudo pacman -Sy --noconfirm mplayer;
```
##### Lecteur de Musique
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
<br />

------------------------------------------------------------------------------------------------------------------
##### Editeur de Texte
```bash
sudo pacman -Sy --noconfirm xed;
```

##### Suite Bureautique
```bash
sudo pacman -Sy --noconfirm libreoffice-fresh libreoffice-fresh-fr
```
<br />

------------------------------------------------------------------------------------------------------------------

##### Divers
```bash
sudo pacman -Sy --noconfirm discord;
sudo pacman -Sy --noconfirm gnome-calculator;
sudo pacman -Sy --noconfirm gnome-calendar;
sudo pacman -Sy --noconfirm gnome-connections;
sudo pacman -Sy --noconfirm gnome-font-viewer;
sudo pacman -Sy --noconfirm gnome-terminal;
```
<br />
