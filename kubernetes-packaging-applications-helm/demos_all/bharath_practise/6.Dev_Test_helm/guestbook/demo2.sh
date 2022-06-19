bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 6.Dev_Test_helm % helm install demo-guestbook guestbook --dry-run --debug
install.go:178: [debug] Original chart version: ""
install.go:195: [debug] CHART PATH: /Users/bahrathkumaraju/external/whatishelm/kubernetes-packaging-applications-helm/demos_all/bharath_practise/6.Dev_Test_helm/guestbook

NAME: demo-guestbook
LAST DEPLOYED: Sun Jun 19 09:31:26 2022
NAMESPACE: default
STATUS: pending-install
REVISION: 1
TEST SUITE: None
USER-SUPPLIED VALUES:
{}

COMPUTED VALUES:
backend:
  global: {}
  image:
    repository: phico/backend
    tag: "2.0"
  ingress:
    enabled: false
    host: backend.minikube.local
  replicaCount: 1
  secret:
    mongodb_uri:
      dbchart: database
      dbconn: guestbook?authSource=admin
      dbport: 27017
      password: password
      username: admin
  service:
    port: 80
    type: ClusterIP
database:
  global: {}
  secret:
    mongodb_password: password
    mongodb_username: admin
  service:
    port: 80
    type: NodePort
  volume:
    storage: 100Mi
frontend:
  config:
    backend_uri: http://backend.minikube.local/guestbook
    guestbook_name: MyPopRock Festival 2.0
  global: {}
  image:
    repository: phico/frontend
    tag: "2.0"
  ingress:
    enabled: false
    host: forntend.minikube.local
  replicaCount: 1
  service:
    port: 80
    type: ClusterIP
ingress:
  hosts:
  - host:
      chart: frontend
      domain: frontend.minikube.local
  - host:
      chart: backend
      domain: backend.minikube.local

HOOKS:
MANIFEST:
---
# Source: guestbook/charts/backend/templates/backend-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo-guestbook-backend-secret
data:
  mongodb-uri: "bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQGRlbW8tZ3Vlc3Rib29rLWRhdGFiYXNlOi9ndWVzdGJvb2s/YXV0aFNvdXJjZT1hZG1pbg=="
#"bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQGRlbW8tZ3Vlc3Rib29rLWRhdGFiYXNlOjI3MDE3L2d1ZXN0Ym9vaz9hdXRoU291cmNlPWFkbWlu"
---
# Source: guestbook/charts/database/templates/mongodb-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo-guestbook-database-secret
data:
  mongodb-username: "YWRtaW4="
  mongodb-password: "cGFzc3dvcmQ="
---
# Source: guestbook/charts/frontend/templates/frontend-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-guestbook-frontend-config
data:
  guestbook-name: MyPopRock Festival 2.0
  backend-uri: http://backend.minikube.local/guestbook
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume.yaml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: demo-guestbook-database-pv
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path:  /mnt/data/demo-guestbook
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume-claim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: demo-guestbook-database-pvc
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
    name: demo-guestbook-backend
  name: demo-guestbook-backend
spec:
  type: ClusterIP
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 3000
  selector:
    app: demo-guestbook-backend
 # type: NodePort
---
# Source: guestbook/charts/database/templates/mongodb-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: demo-guestbook-database
  name: demo-guestbook-database
spec:
 
  ports:
    - name: mongodb
      port: 27017
      targetPort: 27017
  selector:
    app: demo-guestbook-database
---
# Source: guestbook/charts/frontend/templates/frontend-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: demo-guestbook-frontend
  name: demo-guestbook-frontend
spec:
  type: ClusterIP
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 4200
  selector:
    app: demo-guestbook-frontend
---
# Source: guestbook/charts/backend/templates/backend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-guestbook-backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-guestbook-backend
  template:
    metadata:
      labels:
        app: demo-guestbook-backend
    spec:
      containers:
      - image: phico/backend:2.0
        imagePullPolicy: Always
        name: demo-guestbook-backend
        ports:
        - name: http
          containerPort: 3000
        env:
        - name: MONGODB_URI
          valueFrom:
            secretKeyRef:
              name: demo-guestbook-backend-secret
              key: mongodb-uri
---
# Source: guestbook/charts/database/templates/mongodb.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-guestbook-database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-guestbook-database
  template:
    metadata:
      labels:
        app: demo-guestbook-database
    spec:
      containers:
        - image: mongo
          env:
          - name: MONGO_INITDB_DATABASE
            value: guestbook
          - name: MONGO_INITDB_ROOT_USERNAME
            valueFrom:
              secretKeyRef:
                name: demo-guestbook-database-secret
                key: mongodb-username
          - name: MONGO_INITDB_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: demo-guestbook-database-secret
                key: mongodb-password
          name: demo-guestbook-database
          ports:
            - name: mongodb
              containerPort: 27017
          volumeMounts:
            - name: demo-guestbook-database-volume
              mountPath: /data/db
      volumes:
        - name: demo-guestbook-database-volume
          persistentVolumeClaim:
            claimName: demo-guestbook-database-pvc
---
# Source: guestbook/charts/frontend/templates/frontend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-guestbook-frontend
spec:
  replicas: 1 
  selector:
    matchLabels:
      app: demo-guestbook-frontend 
  template:
    metadata: 
      labels:
        app: demo-guestbook-frontend
    spec:
      containers:
      - image: phico/frontend:2.0
        imagePullPolicy: Always
        name: demo-guestbook-frontend
        ports:
        - name: http
          containerPort: 4200
        env:
        - name: BACKEND_URI
          valueFrom:
            configMapKeyRef:
              name: demo-guestbook-frontend-config
              key: backend-uri
        - name: GUESTBOOK_NAME
          valueFrom:
            configMapKeyRef:
              name: demo-guestbook-frontend-config
              key: guestbook-name
---
# Source: guestbook/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-guestbook-guestbook-ingress
spec:
  rules:
  - host: demo-guestbook.frontend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: demo-guestbook-frontend
            port: 
              number: 80
  - host: demo-guestbook.backend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: demo-guestbook-backend
            port: 
              number: 80

NOTES:
Congratulations ! You installed guestbook chart sucessfully.
Release name is demo-guestbook

You can access the Guestbook application at the following urls :
  http://demo-guestbook.frontend.minikube.local
  http://demo-guestbook.backend.minikube.local
Have fun !
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 6.Dev_Test_helm %

