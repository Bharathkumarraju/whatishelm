bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % helm list
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
dev     default         1               2022-06-20 07:45:59.178724 +0800 +08    deployed        guestbook-1.1.0 2.0        
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % helm get manifest dev
---
# Source: guestbook/charts/backend/templates/backend-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: dev-backend-secret
data:
  mongodb-uri: "bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQGRldi1kYXRhYmFzZTovZ3Vlc3Rib29rP2F1dGhTb3VyY2U9YWRtaW4="
#"bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQGRldi1kYXRhYmFzZToyNzAxNy9ndWVzdGJvb2s/YXV0aFNvdXJjZT1hZG1pbg=="
---
# Source: guestbook/charts/database/templates/mongodb-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: dev-database-secret
data:
  mongodb-username: "YWRtaW4="
  mongodb-password: "cGFzc3dvcmQ="
---
# Source: guestbook/charts/frontend/templates/frontend-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: dev-frontend-config
data:
  guestbook-name: MyPopRock Festival 2.0
  backend-uri: http://backend.minikube.local/guestbook
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume.yaml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: dev-database-pv
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path:  /mnt/data/dev
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume-claim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dev-database-pvc
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 100Mi
---
# Source: guestbook/charts/backend/templates/backend-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: dev-backend
  name: dev-backend
spec:
  type: ClusterIP
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 3000
  selector:
    app: dev-backend
 # type: NodePort
---
# Source: guestbook/charts/database/templates/mongodb-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: dev-database
  name: dev-database
spec:
 
  ports:
    - name: mongodb
      port: 27017
      targetPort: 27017
  selector:
    app: dev-database
---
# Source: guestbook/charts/frontend/templates/frontend-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: dev-frontend
  name: dev-frontend
spec:
  type: ClusterIP
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 4200
  selector:
    app: dev-frontend
---
# Source: guestbook/charts/backend/templates/backend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev-backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: dev-backend
  template:
    metadata:
      labels:
        app: dev-backend
    spec:
      containers:
      - image: phico/backend:2.0
        imagePullPolicy: Always
        name: dev-backend
        ports:
        - name: http
          containerPort: 3000
        env:
        - name: MONGODB_URI
          valueFrom:
            secretKeyRef:
              name: dev-backend-secret
              key: mongodb-uri
---
# Source: guestbook/charts/database/templates/mongodb.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev-database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: dev-database
  template:
    metadata:
      labels:
        app: dev-database
    spec:
      containers:
        - image: mongo
          env:
          - name: MONGO_INITDB_DATABASE
            value: guestbook
          - name: MONGO_INITDB_ROOT_USERNAME
            valueFrom:
              secretKeyRef:
                name: dev-database-secret
                key: mongodb-username
          - name: MONGO_INITDB_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: dev-database-secret
                key: mongodb-password
          name: dev-database
          ports:
            - name: mongodb
              containerPort: 27017
          volumeMounts:
            - name: dev-database-volume
              mountPath: /data/db
      volumes:
        - name: dev-database-volume
          persistentVolumeClaim:
            claimName: dev-database-pvc
---
# Source: guestbook/charts/frontend/templates/frontend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev-frontend
spec:
  replicas: 1 
  selector:
    matchLabels:
      app: dev-frontend 
  template:
    metadata: 
      labels:
        app: dev-frontend
    spec:
      containers:
      - image: phico/frontend:2.0
        imagePullPolicy: Always
        name: dev-frontend
        ports:
        - name: http
          containerPort: 4200
        env:
        - name: BACKEND_URI
          valueFrom:
            configMapKeyRef:
              name: dev-frontend-config
              key: backend-uri
        - name: GUESTBOOK_NAME
          valueFrom:
            configMapKeyRef:
              name: dev-frontend-config
              key: guestbook-name
---
# Source: guestbook/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dev-guestbook-ingress
spec:
  rules:
  - host: dev.frontend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: dev-frontend
            port: 
              number: 80
  - host: dev.backend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: dev-backend
            port: 
              number: 80

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies %


helm dependency build guestbook 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % helm install dev guestbook --set backend.enabled=false --set database.enabled=false
NAME: dev
LAST DEPLOYED: Mon Jun 20 08:05:00 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Congratulations ! You installed guestbook chart sucessfully.
Release name is dev

You can access the Guestbook application at the following urls :
  http://dev.frontend.minikube.local
  http://dev.backend.minikube.local
Have fun !
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % kubectl get pods                                                                   
NAME                            READY   STATUS              RESTARTS   AGE
dev-frontend-7dfff6cb7b-5xgcb   0/1     ContainerCreating   0          4s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
dev-frontend-7dfff6cb7b-5xgcb   1/1     Running   0          7s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % helm install dev guestbook --set tags.api=false
NAME: dev
LAST DEPLOYED: Mon Jun 20 08:09:13 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Congratulations ! You installed guestbook chart sucessfully.
Release name is dev

You can access the Guestbook application at the following urls :
  http://dev.frontend.minikube.local
  http://dev.backend.minikube.local
Have fun !
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
dev-frontend-7dfff6cb7b-jbsjl   1/1     Running   0          7s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % 

