------------------------------------------------------------------------------------------------------------------------------------------------------
### <p align='center'> Création du Conteneur Portainer </p>

------------------------------------------------------------------------------------------------------------------------------------------------------
#### Script
```bash
clear;
docker pull portainer/portainer-ce;
docker container rm -f Portainer;
docker run -d \
  -p 8000:8000 \
  -p 9000:9000 \
  --label Cacher="Oui" \
  --name=Portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v Portainer:/data \
  -v /etc/localtime:/etc/localtime:ro \
  portainer/portainer-ce;

#docker volume create Portainer;

```

#### Accéder à l'URL
```
http://192.168.0.3:9000
```
