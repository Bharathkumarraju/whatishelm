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




