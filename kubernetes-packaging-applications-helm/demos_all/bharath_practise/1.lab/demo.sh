helm install --generate-name [chart]

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % helm install demo-guestbook guestbook
NAME: demo-guestbook
LAST DEPLOYED: Thu Jun 16 07:46:36 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % helm list --short
bkchart
chartmuseum
demo-guestbook
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
demo-guestbook  default         1               2022-06-16 07:46:36.572215 +0800 +08    deployed        guestbook-0.1.0 1.0        
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % helm list --short
demo-guestbook
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % helm get manifest demo-guestbook
---
# Source: guestbook/templates/frontend-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: frontend
  name: frontend
spec:
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 4200
  selector:
    app: frontend
---
# Source: guestbook/templates/frontend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend 
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - image: phico/frontend:1.0
        imagePullPolicy: Always
        name: frontend
        ports:
        - name: frontend
          containerPort: 4200
---
# Source: guestbook/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: guestbook-ingress
spec:
  rules:
  - host: frontend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port: 
              number: 80
  - host: backend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: backend
            port: 
              number: 80

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 1.lab % 




Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$ kubectl describe pod -l app=frontend
Name:         frontend-6ff649b7c7-rbzns
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Thu, 16 Jun 2022 08:05:27 +0800
Labels:       app=frontend
              pod-template-hash=6ff649b7c7
Annotations:  <none>
Status:       Running
IP:           172.17.0.6
IPs:
  IP:           172.17.0.6
Controlled By:  ReplicaSet/frontend-6ff649b7c7
Containers:
  frontend:
    Container ID:   docker://d03bfcd5f3264cd66fc0e501024abdd82bd27f1f6658bdff9c5e4a0de269cbd4
    Image:          phico/frontend:1.1
    Image ID:       docker-pullable://phico/frontend@sha256:de0a440d2de76f394f53ca537eb0b8bffb0fa7b6fc28cc74bed2dc98b64c36ec
    Port:           4200/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 16 Jun 2022 08:05:35 +0800
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6mrcm (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-6mrcm:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  63s   default-scheduler  Successfully assigned default/frontend-6ff649b7c7-rbzns to minikube
  Normal  Pulling    63s   kubelet            Pulling image "phico/frontend:1.1"
  Normal  Pulled     57s   kubelet            Successfully pulled image "phico/frontend:1.1" in 6.568241003s
  Normal  Created    57s   kubelet            Created container frontend
  Normal  Started    56s   kubelet            Started container frontend
Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$


Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$ helm status demo-guestbook
NAME: demo-guestbook
LAST DEPLOYED: Thu Jun 16 08:05:27 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$ 



Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$ helm status demo-guestbook
NAME: demo-guestbook
LAST DEPLOYED: Thu Jun 16 08:05:27 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$ helm rollback demo-guestbook 1
Rollback was a success! Happy Helming!
Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$ helm history demo-guestbook
REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION     
1               Thu Jun 16 07:52:51 2022        superseded      guestbook-0.1.0 1.0             Install complete
2               Thu Jun 16 08:05:27 2022        superseded      guestbook-0.1.0 1.1             Upgrade complete
3               Thu Jun 16 08:16:05 2022        deployed        guestbook-0.1.0 1.0             Rollback to 1   
Bahrathkumarajus-MacBook-Pro:1.lab bahrathkumaraju$ 


