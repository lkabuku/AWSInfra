#Docker Community Edition (Docker CE)

##Definition

Docker CE for Ubuntu [...] simplify provisioning and setup of Docker and accelerate your time to value in building and deploying container based applications ([see more](https://store.docker.com/editions/community/docker-ce-server-ubuntu))


## Linux OS : Ubuntu Xenial 16.04 (LTS)

### Uninstall old version
```
sudo apt-get remove docker docker-engine docker.io
sudo rm -rf /var/lib/docker
```

### Install docker dependencies
```
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```


### Add Docker’s official GPG key
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.
```
sudo apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
```

### Add a docker repository stable
```
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update
```

### Install docker-engine
```
mkdir -p /etc/apt/sources.list.d
echo deb [arch=amd64] https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list
sudo apt-get update 
sudo apt-get install -y -q docker-engine
```

#### Verify that Docker CE is installed correctly by running the hello-world image.
```
sudo docker run hello-world
```

#### AWS Configure
```
aws confgure
```

#### AWS Get Login
```
eval $(aws ecr get-login --registry-ids <aws_account_id>)
```
docker login -u AWS -p <password> -e none https://<aws_account_id>.dkr.ecr.<region>.amazonaws.com

Voir: https://docs.aws.amazon.com/cli/latest/reference/ecr/get-login.html
Voir: http://help2.tracker-rms.com/knowledgebase/configuring-your-network-settings-to-use-google-public-dns


## Liste des images de AWS Registry
```
aws ecr list-images --repository-name skopiteam
```

* eb ssh
* eb configure
* ssh -i ssh***.pem ec2-user@***