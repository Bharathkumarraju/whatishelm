bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % helm install demo-guestbook guestbook --dry-run --debug
install.go:178: [debug] Original chart version: ""
install.go:195: [debug] CHART PATH: /Users/bahrathkumaraju/external/whatishelm/kubernetes-packaging-applications-helm/demos_all/bharath_practise/3.lab_templates/guestbook

NAME: demo-guestbook
LAST DEPLOYED: Fri Jun 17 08:05:33 2022
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
    host: backend.minikube.local
  replicaCount: 1
  secret:
    mongodb_uri: bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQG1vbmdvZGI6MjcwMTcvZ3Vlc3Rib29rP2F1dGhTb3VyY2U9YWRtaW4=
  service:
    port: 80
    type: ClusterIP
database:
  global: {}
  secret:
    mongodb_password: cGFzc3dvcmQ=
    mongodb_username: YWRtaW4=
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
    host: forntend.minikube.local
  replicaCount: 1
  service:
    port: 80
    type: ClusterIP

HOOKS:
MANIFEST:
---
# Source: guestbook/charts/backend/templates/backend-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo-guestbook-backend-secret
data:
  mongodb-uri: bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQG1vbmdvZGI6MjcwMTcvZ3Vlc3Rib29rP2F1dGhTb3VyY2U9YWRtaW4=
---
# Source: guestbook/charts/database/templates/mongodb-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo-guestbook-database-secret
data:
  mongodb-username: YWRtaW4=
  mongodb-password: cGFzc3dvcmQ=
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
  type: NodePort
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
# Source: guestbook/charts/backend/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-guestbook-backend-ingress
spec:
  rules:
  - host: backend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: demo-guestbook-backend
            port: 
              number: 80
---
# Source: guestbook/charts/frontend/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-guestbook-frontend-ingress
spec:
  rules:
  - host: forntend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: demo-guestbook-frontend
            port: 
              number: 80

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % 