
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ tree guestbook/
guestbook/
├── Chart.yaml
└── charts
    ├── backend
    │   ├── Chart.yaml
    │   └── templates
    │       ├── backend-secret.yaml
    │       ├── backend-service.yaml
    │       └── backend.yaml
    ├── database
    │   ├── Chart.yaml
    │   └── templates
    │       ├── mongodb-persistent-volume-claim.yaml
    │       ├── mongodb-persistent-volume.yaml
    │       ├── mongodb-secret.yaml
    │       ├── mongodb-service.yaml
    │       └── mongodb.yaml
    └── frontend
        ├── Chart.yaml
        └── templates
            ├── frontend-configmap.yaml
            ├── frontend-service.yaml
            ├── frontend.yaml
            └── ingress.yaml

7 directories, 16 files
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ 

Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ helm list --short
demo-guestbook
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ helm list 
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
demo-guestbook  default         3               2022-06-16 08:16:05.266438 +0800 +08    deployed        guestbook-0.1.0 1.0        
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ 



Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ kubectl get all
NAME                            READY   STATUS              RESTARTS   AGE
pod/backend-67b4ffc69d-mhzbg    0/1     ContainerCreating   0          7s
pod/frontend-7d565f98bb-rn2xv   1/1     Running             0          26m
pod/frontend-85fbc6fb7b-cs8km   0/1     ContainerCreating   0          6s
pod/mongodb-584d56b865-zdmpc    0/1     ContainerCreating   0          7s

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)           AGE
service/backend      ClusterIP   10.109.193.40    <none>        80/TCP            8s
service/frontend     ClusterIP   10.103.191.161   <none>        80/TCP            50m
service/kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP           34h
service/mongodb      NodePort    10.101.103.72    <none>        27017:30943/TCP   8s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/backend    0/1     1            0           8s
deployment.apps/frontend   1/1     1            1           50m
deployment.apps/mongodb    0/1     1            0           8s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/backend-67b4ffc69d    1         1         0       8s
replicaset.apps/frontend-6ff649b7c7   0         0         0       37m
replicaset.apps/frontend-7d565f98bb   1         1         1       50m
replicaset.apps/frontend-85fbc6fb7b   1         1         0       8s
replicaset.apps/mongodb-584d56b865    1         1         0       8s
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ kubectl get all
NAME                            READY   STATUS              RESTARTS   AGE
pod/backend-67b4ffc69d-mhzbg    0/1     Error               0          17s
pod/frontend-7d565f98bb-rn2xv   1/1     Running             0          26m
pod/frontend-85fbc6fb7b-cs8km   0/1     ContainerCreating   0          16s
pod/mongodb-584d56b865-zdmpc    0/1     ContainerCreating   0          17s

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)           AGE
service/backend      ClusterIP   10.109.193.40    <none>        80/TCP            17s
service/frontend     ClusterIP   10.103.191.161   <none>        80/TCP            50m
service/kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP           34h
service/mongodb      NodePort    10.101.103.72    <none>        27017:30943/TCP   17s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/backend    0/1     1            0           17s
deployment.apps/frontend   1/1     1            1           50m
deployment.apps/mongodb    0/1     1            0           17s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/backend-67b4ffc69d    1         1         0       17s
replicaset.apps/frontend-6ff649b7c7   0         0         0       37m
replicaset.apps/frontend-7d565f98bb   1         1         1       50m
replicaset.apps/frontend-85fbc6fb7b   1         1         0       17s
replicaset.apps/mongodb-584d56b865    1         1         0       17s
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$


Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ helm list 
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
demo-guestbook  default         3               2022-06-16 08:16:05.266438 +0800 +08    deployed        guestbook-0.1.0 1.0        
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ helm upgrade demo-guestbook guestbook
Release "demo-guestbook" has been upgraded. Happy Helming!
NAME: demo-guestbook
LAST DEPLOYED: Thu Jun 16 08:42:43 2022
NAMESPACE: default
STATUS: deployed
REVISION: 4
TEST SUITE: None
Bahrathkumarajus-MacBook-Pro:

