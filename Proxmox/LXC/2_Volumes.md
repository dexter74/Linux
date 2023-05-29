#### Création de Volume qui accéde au partage.

```yml
  volumes
   - 'DOWNLOAD:/media/Download:rw'
   - 'MUSIC:/media/Music:ro'
   - 'VIDEO:/media/Video:rw'
   - 'VIDEO2:/media/Video2:rw'
   - 'PERSO:/media/Perso:ro'
   - 'HENTAI:/media/Hentai:ro'
  #- 'MyPhoto:/media/MyPhoto:ro'
```

```yml
volumes:
 DOWNLOAD:
  external: true

 MUSIC:
  external: true

 VIDEO:
  external: true

 VIDEO2:
  external: true

 PERSO:
  external: true

 HENTAI:
  external: true

#MyPhoto:
# external: true
```



```yml
NAS=192.168.0.3
UTILISATEUR=marc
MOTDEPASSE=admin

PARTAGE_1=Download
PARTAGE_2=Video
PARTAGE_3=Music
PARTAGE_4=Home/MyPhoto
PARTAGE_5=Video2
PARTAGE_6=Perso
PARTAGE_7=Hentai

NAME_1=DOWNLOAD
NAME_2=VIDEO
NAME_3=MUSIC
NAME_4=MyPhoto
NAME_5=VIDEO2
NAME_6=PERSO
NAME_7=HENTAI

# Suppression des volumes
docker volume rm -f ${NAME_1};
docker volume rm -f ${NAME_2};
docker volume rm -f ${NAME_3};
docker volume rm -f ${NAME_4};
docker volume rm -f ${NAME_5};
docker volume rm -f ${NAME_6};
docker volume rm -f ${NAME_7};


docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_1} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_1};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_2} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_2};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_3} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_3};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_4} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_4};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_5} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_5};

docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_6} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_6};
        
docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${NAS}/${PARTAGE_7} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_7};

# ,vers=3.0,file_mode=0777,dir_mode=0777
```

