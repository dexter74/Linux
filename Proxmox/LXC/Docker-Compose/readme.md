#### Torrent
```bash
clear;
# ------------------------------------------------------------------------------------------------------------------
CHEMIN=/var/lib/docker/volumes/
STACK=warez
CONTENEUR=Qbittorrent
# ------------------------------------------------------------------------------------------------------------------
docker stop qbittorrent;
# ------------------------------------------------------------------------------------------------------------------
echo "[BitTorrent]
Session\Port=60221
Session\QueueingSystemEnabled=false

[Downloads]
SavePath=/media/Download/Torrent

[%General]
Locale=fr_FR
General\Locale=fr_FR

[Meta]
MigrationVersion=4

[Preferences]
WebUI\Port=1007
WebUI\HostHeaderValidation=false

[WebUI]
HostHeaderValidation=false" > $CHEMIN/${STACK}_Qbittorrent/_data/qBittorrent/qBittorrent.conf
# ------------------------------------------------------------------------------------------------------------------
docker start qbittorrent;
```
