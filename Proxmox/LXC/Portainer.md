------------------------------------------------------------------------------------------------------------------------------------------------------
### <p align='center'> Création du Conteneur Portainer </p>

------------------------------------------------------------------------------------------------------------------------------------------------------
#### Script
```bash
clear;
docker kill Portainer;
docker container rm -f Portainer;
docker volume create Portainer;
docker pull portainer/portainer-ce;
docker run -d \
  -p 8000:8000 \
  -p 9000:9000 \
  --label cacher="oui" \
  --name=CPortainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v Portainer:/data \
  -v /etc/localtime:/etc/localtime:ro \
  portainer/portainer-ce \
  --hide-label Cacher="Oui"
```

#### Accéder à l'URL
```
Port 9000 en http
```
