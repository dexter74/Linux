#### Création des Volumes
```
STORAGE=192.168.0.3
USERNAME=Drthrax74
PASSWORD=
SHARE_1=Download

docker volume create \
  --driver local --opt type=cifs \
  --opt device=//$STORAGE/$SHARE_1 \
  --opt o=username=$USERNAME,password=$PASSWORD,vers=3.0,file_mode=0777,dir_mode=0777 \
  --name $SHARE_1;
  ```
