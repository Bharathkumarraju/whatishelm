bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % helm install demo-guestbook guestbook
NAME: demo-guestbook
LAST DEPLOYED: Fri Jun 17 08:12:28 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % kubectl get all
NAME                                           READY   STATUS             RESTARTS     AGE
pod/demo-guestbook-backend-5bc9fd784-czx9c     0/1     CrashLoopBackOff   1 (8s ago)   21s
pod/demo-guestbook-database-78fbf8b9d-hshld    1/1     Running            0            21s
pod/demo-guestbook-frontend-58dd8d7578-c5d7h   1/1     Running            0            21s

NAME                              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)     AGE
service/demo-guestbook-backend    ClusterIP   10.98.205.94    <none>        80/TCP      21s
service/demo-guestbook-database   ClusterIP   10.108.168.47   <none>        27017/TCP   21s
service/demo-guestbook-frontend   ClusterIP   10.109.19.106   <none>        80/TCP      21s
service/kubernetes                ClusterIP   10.96.0.1       <none>        443/TCP     2d10h

NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/demo-guestbook-backend    0/1     1            0           21s
deployment.apps/demo-guestbook-database   1/1     1            1           21s
deployment.apps/demo-guestbook-frontend   1/1     1            1           21s

NAME                                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/demo-guestbook-backend-5bc9fd784     1         1         0       21s
replicaset.apps/demo-guestbook-database-78fbf8b9d    1         1         1       21s
replicaset.apps/demo-guestbook-frontend-58dd8d7578   1         1         1       21s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % 
