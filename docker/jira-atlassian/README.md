# Définition de la construction de l'image "app_jira"

Le fichier Dockerfile défini la construction de l'image 'app_jira'. 
Cette image sera ensuite poussée dans AWS registry.

L'image créée contiendra :
* atlassian jira software

## Construction de l'image 'app_jira'
```
docker build -t app_jira  -f ./Dockerfile .
```

## Lancer le container 'app_jira:latest '
```
docker run -d app_jira:latest 
docker run -d -p 80:80 -p 8080:8080 -p 8088:8088 app_jira:latest 
```

## Aller dans le container
```
docker ps # pour lister les images en cours d'execution, recuperer l'id du Container
docker exec -itu root {CONTAINER ID} /bin/bash --login
```

## Déploiement de l'image (app_jira) chez AWS Registry
```
docker tag IMAGE_BASIC_ID ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/REPOSITORY_ID:app_jira
docker push ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/REPOSITORY_ID:app_jira
```

## Connexion SSH à AWS EBS
```
eb configure
```