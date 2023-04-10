##### Navigateurs
```bash
yay -Sy --noconfirm microsoft-edge-stable-bin;
```
##### Coffre-fort
```bash
pacman -Sy --noconfirm seahorse;
```
##### Lecteur Multimédias
```bash
pacman -Sy --noconfirm smplayer;
pacman -Sy --noconfirm mplayer;
```

### Configurer Smplayer
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




##### Lecteur Musique
```bash
yay -Sy --noconfirm rhythmbox;
yay -Sy --noconfirm rhythmbox-plugin-hide-git;
yay -Sy --noconfirm rhythmbox-plugin-tray-icon;
yay -Sy --noconfirm rhythmbox-tray-icon;
yay -Sy --noconfirm papirus-smplayer-theme-git;

```



##### Logiciels
```bash
pacman -Sy --noconfirm discord;
pacman -Sy --noconfirm file-roller;
pacman -Sy --noconfirm gnome-{calculator,calendar,font-viewer,terminal};
pacman -Sy --noconfirm numlockx;
pacman -Sy --noconfirm virtualbox virtualbox-guest-iso virtualbox-host-modules-arch;
echo "* 192.168.1.0/24
* 192.168.2.0/24
* 192.168.3.0/24
* 192.168.4.0/24
* 192.168.5.0/24" > /etc/vbox/networks.conf;

yay -Sy --noconfirm blivet-gui
yay -Sy --noconfirm menulibre;
yay -Sy --noconfirm mugshot;
yay -Sy --noconfirm mpc-qt;
yay -Sy --noconfirm pamac-aur;
yay -Sy --noconfirm protonup-qt;
yay -Sy --noconfirm sysmontask;
yay -Sy --noconfirm timeshift;
yay -Sy --noconfirm virtualbox-ext-oracle;
yay -Sy --noconfirm xfce4-panel-profiles;
```

##### Themes
```bash
yay -Sy --noconfirm dracula-gtk-theme;
yay -Sy --noconfirm papirus-icon-theme-git;
```

##### Polices
```bash
curl https://fonts.google.com/download?family=Roboto --output /tmp/roboto.zip; unzip /tmp/roboto.zip -d /usr/share/fonts;
yay -Sy --noconfirm ttf-ms-win10-auto;
```

##### Non Classé
```bash
amdvlk
dpkg
mesa-utils
opencl-mesa
systemd-ui
```
