# Définition de la construction de l'image "app_sample"

Le fichier Dockerfile défini la construction de l'image 'app_sample'. 
Cette image sera ensuite poussée dans AWS registry.

L'image créée contiendra :
* le serveur Apache2
* des utilitaires de linux tels que : sudo, curl, vim, etc.


## Construction de l'image 'app_sample'
```
docker build -t app_sample  -f ./Dockerfile .
```

## Lancer le container 'app_sample:latest '
```
docker run -d app_sample:latest 
docker run -d -p 80:80 app_sample:latest 
```

## Aller dans le container
```
docker ps # pour lister les images en cours d'execution, recuperer l'id du Container
docker exec -itu root {CONTAINER ID} /bin/bash --login
```

## Déploiement de l'image (app_sample) chez AWS Registry
```
docker tag IMAGE_BASIC_ID 846572358120.dkr.ecr.eu-west-1.amazonaws.com/skopiteam:app_sample
docker push 846572358120.dkr.ecr.eu-west-1.amazonaws.com/skopiteam:app_sample
```
