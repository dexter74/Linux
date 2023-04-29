#### Torrent
```
FICHIER=/var/lib/docker/volumes/warez_Qbittorrent/_data/qBittorrent.conf
docker stop qbittorrent;
echo "WebUI\HostHeaderValidation=false"            >> $FICHIER;
echo "General\Locale=fr_FR"                        >> $FICHIER;
echo "Downloads\SavePath=/mnt/Download/Qbitorrent" >> $FICHIER;
docker start qbittorrent;
```
