how to work with helm

a package manager for kubernetes

Helm V3 - search, Commands


helm charts:
------------------>
tiller removed.

Deployment Service Secret

More complex deployments handled with helm charts

helm install -name mychart ./mychart


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % kubectl get nodes -o wide
NAME       STATUS   ROLES                  AGE     VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
minikube   Ready    control-plane,master   2d14h   v1.23.3   192.168.49.2   <none>        Ubuntu 20.04.2 LTS   5.10.104-linuxkit   docker://20.10.12
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % kubectl config current-context
minikube
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm version
version.BuildInfo{Version:"v3.9.0", GitCommit:"7ceeda6c585217a19a1131663d8cd1f7d641b2a7", GitTreeState:"clean", GoVersion:"go1.18.2"}
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


Helm repo add 
helm search repo 
helm install 
helm install --dry-run 
helm list(status)
helm upgrade 
helm rollback 
helm history
helm create(crate our own chart)
helm package(package it and store it in our own repo)

https://charts.helm.sh/stable/

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo add stable https://charts.helm.sh/stable
"stable" has been added to your repositories
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 

https://artifacthub.io/


https://artifacthub.io/packages/search?ts_query_web=tyk&sort=relevance&page=1



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo add stable https://kubernetes-charts.storage.googleapis.com
Error: repo "https://kubernetes-charts.storage.googleapis.com" is no longer available; try "https://charts.helm.sh/stable" instead
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo add stable https://charts.helm.sh/stable
"stable" has been added to your repositories
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo list
NAME    URL                          
stable  https://charts.helm.sh/stable
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm search repo stable/mysql      
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
stable/mysql            1.6.9           5.7.30          DEPRECATED - Fast, reliable, scalable, and easy...
stable/mysqldump        2.6.2           2.4.1           DEPRECATED! - A Helm chart to help backup MySQL...
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 




