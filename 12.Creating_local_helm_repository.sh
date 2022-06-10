openssource helm chart repository: chart museum 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm list
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
bkchart default         2               2022-06-10 09:46:18.196566 +0800 +08    deployed        bkchart-0.1.0   1.16.0     
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % cd custom_charts 
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % helm upgrade  bkchart ./bkchart --set containerImage=nginx:1.19    
Release "bkchart" has been upgraded. Happy Helming!
NAME: bkchart
LAST DEPLOYED: Fri Jun 10 10:12:15 2022
NAMESPACE: default
STATUS: deployed
REVISION: 3
TEST SUITE: None
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % kubectl get deployment -o jsonpath='{ .items[*].spec.template.spec.containers[*].image }'
nginx:1.19%                                                                                                                                                                                                                                                    
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % 


deploy chartmuseum locally


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % helm install chartmuseum stable/chartmuseum --set env.open.DISABLE_API=false
WARNING: This chart is deprecated
NAME: chartmuseum
LAST DEPLOYED: Fri Jun 10 10:57:31 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

Get the ChartMuseum URL by running:

  export POD_NAME=$(kubectl get pods --namespace default -l "app=chartmuseum" -l "release=chartmuseum" -o jsonpath="{.items[0].metadata.name}")
  echo http://127.0.0.1:8080/
  kubectl port-forward $POD_NAME 8080:8080 --namespace default
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % export POD_NAME=$(kubectl get pods --namespace default -l "app=chartmuseum" -l "release=chartmuseum" -o jsonpath="{.items[0].metadata.name}")
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % echo http://127.0.0.1:8080/
http://127.0.0.1:8080/
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % kubectl port-forward $POD_NAME 8080:8080 --namespace default
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080



Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ helm repo add chartmuseum http://127.0.0.1:8080/
"chartmuseum" has been added to your repositories
Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ 



Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ curl --data-binary "@bkchart-0.1.0.tgz" http://127.0.0.1:8080/api/charts
{"saved":true}
Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ 


Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "chartmuseum" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ helm search repo chartmuseum/bkchart
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                
chartmuseum/bkchart     0.1.0           1.16.0          A Helm chart for Kubernetes
Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ 

Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ helm --help
  -n, --namespace string            namespace scope for this request
      --registry-config string      path to the registry config file (default "/Users/bahrathkumaraju/Library/Preferences/helm/registry/config.json")
      --repository-cache string     path to the file containing cached repository indexes (default "/Users/bahrathkumaraju/Library/Caches/helm/repository")
      --repository-config string    path to the file containing repository names and URLs (default "/Users/bahrathkumaraju/Library/Preferences/helm/repositories.yaml")

Use "helm [command] --help" for more information about a command.


Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ cat /Users/bahrathkumaraju/Library/Preferences/helm/repositories.yaml
apiVersion: ""
generated: "0001-01-01T00:00:00Z"
repositories:
- caFile: ""
  certFile: ""
  insecure_skip_tls_verify: false
  keyFile: ""
  name: stable
  pass_credentials_all: false
  password: ""
  url: https://charts.helm.sh/stable
  username: ""
- caFile: ""
  certFile: ""
  insecure_skip_tls_verify: false
  keyFile: ""
  name: chartmuseum
  pass_credentials_all: false
  password: ""
  url: http://127.0.0.1:8080/
  username: ""
Bahrathkumarajus-MacBook-Pro:whatishelm bahrathkumaraju$ cd /Users/bahrathkumaraju/Library/Caches/helm/repository
Bahrathkumarajus-MacBook-Pro:repository bahrathkumaraju$ ls -rtlh
total 19408
-rw-r--r--  1 bahrathkumaraju  staff    11K 10 Jun 07:54 mysql-1.6.9.tgz
-rw-r--r--  1 bahrathkumaraju  staff    11K 10 Jun 08:31 mysql-1.6.8.tgz
-rw-r--r--  1 bahrathkumaraju  staff    11K 10 Jun 08:43 mysql-1.6.3.tgz
-rw-r--r--  1 bahrathkumaraju  staff    11K 10 Jun 08:43 mysql-1.6.5.tgz
-rw-r--r--  1 bahrathkumaraju  staff    11K 10 Jun 08:44 mysql-1.6.7.tgz
-rw-r--r--  1 bahrathkumaraju  staff    16K 10 Jun 10:57 chartmuseum-2.14.2.tgz
-rw-r--r--  1 bahrathkumaraju  staff     8B 10 Jun 11:46 chartmuseum-charts.txt
-rw-r--r--  1 bahrathkumaraju  staff   394B 10 Jun 11:46 chartmuseum-index.yaml
-rw-r--r--  1 bahrathkumaraju  staff   3.3K 10 Jun 11:46 stable-charts.txt
-rw-r--r--  1 bahrathkumaraju  staff   9.4M 10 Jun 11:46 stable-index.yaml
Bahrathkumarajus-MacBook-Pro:repository bahrathkumaraju$ cat chartmuseum-index.yaml
apiVersion: v1
entries:
  bkchart:
  - apiVersion: v2
    appVersion: 1.16.0
    created: "2022-06-10T03:03:13.912766012Z"
    description: A Helm chart for Kubernetes
    digest: a90ad2886b6aa9ad0a827c9f2746c0003b2017878dcbba12072be6f0a9859a18
    name: bkchart
    type: application
    urls:
    - charts/bkchart-0.1.0.tgz
    version: 0.1.0
generated: "2022-06-10T03:03:36Z"
serverInfo: {}
Bahrathkumarajus-MacBook-Pro:repository bahrathkumaraju$ 


Bahrathkumarajus-MacBook-Pro:repository bahrathkumaraju$ helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
bkchart         default         3               2022-06-10 10:12:15.344728 +0800 +08    deployed        bkchart-0.1.0           1.16.0     
chartmuseum     default         1               2022-06-10 10:57:31.747396 +0800 +08    deployed        chartmuseum-2.14.2      0.12.0     
Bahrathkumarajus-MacBook-Pro:repository bahrathkumaraju$ 


