Charts 
Templates 
Repositories

apt install mysql 
apt update
---------------------in the same manner------------------------

helm install mysql stable/mysql 
helm upgrade mysql stable/mysql 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml % helm repo add stable https://charts.helm.sh/stable                    
"stable" has been added to your repositories
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml % kubectl get secret | grep -i demo-mysql
demo-mysql                          Opaque                                2      87s
sh.helm.release.v1.demo-mysql.v1    helm.sh/release.v1                    1      87s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml % helm uninstall demo-mysql
release "demo-mysql" uninstalled
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml % kubectl get all                        
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   95m
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml % helm env
HELM_BIN="helm"
HELM_CACHE_HOME="/Users/bahrathkumaraju/Library/Caches/helm"
HELM_CONFIG_HOME="/Users/bahrathkumaraju/Library/Preferences/helm"
HELM_DATA_HOME="/Users/bahrathkumaraju/Library/helm"
HELM_DEBUG="false"
HELM_KUBEAPISERVER=""
HELM_KUBEASGROUPS=""
HELM_KUBEASUSER=""
HELM_KUBECAFILE=""
HELM_KUBECONTEXT=""
HELM_KUBETOKEN=""
HELM_MAX_HISTORY="10"
HELM_NAMESPACE="default"
HELM_PLUGINS="/Users/bahrathkumaraju/Library/helm/plugins"
HELM_REGISTRY_CONFIG="/Users/bahrathkumaraju/Library/Preferences/helm/registry/config.json"
HELM_REPOSITORY_CACHE="/Users/bahrathkumaraju/Library/Caches/helm/repository"
HELM_REPOSITORY_CONFIG="/Users/bahrathkumaraju/Library/Preferences/helm/repositories.yaml"
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro yaml %

