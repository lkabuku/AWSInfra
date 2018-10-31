# Définition de la construction de l'image "app_core"

Le fichier Dockerfile défini la construction de l'image 'app_core'. 
Cette image sera ensuite poussée dans AWS registry.

L'image créée contiendra :
* le serveur Apache2
* l'interpréteur PHP
* des utilitaires de linux tels que : sudo, curl, vim, etc.

## Construction de l'image 'app_core'
```
docker build -t app_core  -f ./Dockerfile .
```

## Lancer le container 'app_core:latest '
```
docker run -d app_core:latest 
docker run -d -p 80:80 -p 8080:8080 -p 8088:8088 app_core:latest 
```

## Aller dans le container
```
docker ps # pour lister les images en cours d'execution, recuperer l'id du Container
docker exec -itu root {CONTAINER ID} /bin/bash --login
```

## Déploiement de l'image (app_core) chez AWS Registry
```
docker tag IMAGE_BASIC_ID ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/REPOSITORY_ID:app_core
docker push ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/REPOSITORY_ID:app_core
```