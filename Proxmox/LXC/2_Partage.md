#### LXC
La machine Hôte monte les partages et on déclare dans le conteneur LXC les chemins.
```
nano /etc/pve/lxc/101.conf
mp0: /mnt/Download,mp=/mnt/Download
mp1: /mnt/Home,mp=/mnt/Home
mp2: /mnt/Music,mp=/mnt/Music
mp3: /mnt/Video,mp=/mnt/Video
```
