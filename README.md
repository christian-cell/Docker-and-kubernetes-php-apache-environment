To share and run the backend application made in php in docker

$ git clone this repo
$ cd ejemplo-lamp-kubernetes
$ docker build -t <name of your image:tag> .  "dont forget the point at the end"
$ docker tag <image-name:tag> <yourUserDockerHubName/image-name:tag>
$ docker push <yourUserDockerHubName/image-name:tag>

pull your image

$ docker pull <yourUserDockerHubName/image-name:tag>

to run it in both directions . container ======> your host  , your host ======> container

$ docker run -d --name <container-name> -p 80:80 -v $(pwd)/website:/var/www/html/ <image-name>



To run in kubernetes

after install kubectl and minikube start minikube cluster

$ minikube start --vm-driver=<your virtual machine> ej
$ minikube start --vm-driver=virtualbox

create the namespace lamp-dev 
$ kubectl create namespace lam-dev

move to lamp-dev
$ kubens lamp-dev

and run
./script.sh

get a EXTERNAL IP with
$ minikube tunnel

$ kubectl get svc

copy external ip and pick in your browser
