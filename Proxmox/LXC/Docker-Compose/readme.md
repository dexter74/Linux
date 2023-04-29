#### Torrent
```bash
clear;
docker stop qbittorrent;
# ------------------------------------------------------------------------------------------------------------------
echo "[BitTorrent]
Session\Port=60221
Session\QueueingSystemEnabled=false

[Downloads]
SavePath=/mnt/Download/Qbitorrent

[%General]
Locale=fr_FR
General\Locale=fr_FR

[Meta]
MigrationVersion=4

[Preferences]
WebUI\Port=1007
WebUI\HostHeaderValidation=false

[WebUI]
HostHeaderValidation=false" > /var/lib/docker/volumes/warez_Qbittorrent/_data/qBittorrent/qBittorrent.conf
# ------------------------------------------------------------------------------------------------------------------
docker start qbittorrent;
```
