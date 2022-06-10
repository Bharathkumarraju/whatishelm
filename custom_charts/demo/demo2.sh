bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % echo "containerImage: nginx:1.17" > bkchart/values.yaml 
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % helm install bkchart ./bkchart 
NAME: bkchart
LAST DEPLOYED: Fri Jun 10 09:43:03 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % helm list
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
bkchart default         1               2022-06-10 09:43:03.477367 +0800 +08    deployed        bkchart-0.1.0   1.16.0     
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % kubectl get all
NAME                          READY   STATUS    RESTARTS   AGE
pod/bkchart-5fbc65fff-88m42   1/1     Running   0          46s

NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/kubernetes   ClusterIP      10.96.0.1        <none>        443/TCP        2d17h
service/nginx        LoadBalancer   10.109.223.250   127.0.0.1     80:31530/TCP   46s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/bkchart   1/1     1            1           46s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/bkchart-5fbc65fff   1         1         1       46s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % 




bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % kubectl get deployment -o jsonpath='{ .items[*].spec.template.spec.containers[*].image }'
nginx:1.17%                                                                                                                                                                                                                                                    
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % helm upgrade  bkchart ./bkchart --set containerImage=nginx:1.18                   
Release "bkchart" has been upgraded. Happy Helming!
NAME: bkchart
LAST DEPLOYED: Fri Jun 10 09:46:18 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts %


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % kubectl get deployment -o jsonpath='{ .items[*].spec.template.spec.containers[*].image }'
nginx:1.18%                                                                                                                                                                                                                                                    
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % 

