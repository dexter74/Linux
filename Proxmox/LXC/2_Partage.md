#### Script pour la création des Volumes

```yml
  volumes
   - 'DOWNLOAD:/media/Download:rw'
   - 'MUSIC:/media/Music:ro'
   - 'VIDEO:/media/Video:rw'
   - 'MyPhoto:/media/MyPhoto:ro'
```

```yml
volumes:
 DOWNLOAD:
  external: true

 MUSIC:
  external: true

 VIDEO:
  external: true

 MyPhoto:
  external: true
```



```yml
NAS=192.168.0.3
UTILISATEUR=marc
MOTDEPASSE=admin

PARTAGE_1=Download/Torrent
PARTAGE_2=Video
PARTAGE_3=Music
PARTAGE_4=Home/MyPhoto

NAME_1=DOWNLOAD
NAME_2=VIDEO
NAME_3=MUSIC
NAME_4=MyPhoto

# Suppression des volumes
docker volume rm -f ${NAME_1};
docker volume rm -f ${NAME_2};
docker volume rm -f ${NAME_3};
docker volume rm -f ${NAME_4};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_1} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE},vers=3.0,file_mode=0777,dir_mode=0777 \
        --name ${NAME_1};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_2} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE},vers=3.0,file_mode=0777,dir_mode=0777 \
        --name ${NAME_2};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_3} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE},vers=3.0,file_mode=0777,dir_mode=0777 \
        --name ${NAME_3};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_4} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE},vers=3.0,file_mode=0777,dir_mode=0777 \
        --name ${NAME_4};
```

