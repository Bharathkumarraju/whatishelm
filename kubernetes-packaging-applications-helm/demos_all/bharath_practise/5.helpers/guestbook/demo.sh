bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 5.helpers % helm template guestbook       
---
# Source: guestbook/charts/backend/templates/backend-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: release-name-backend-secret
  mongodb-uri: "bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQHJlbGVhc2UtbmFtZS1kYXRhYmFzZTovZ3Vlc3Rib29rP2F1dGhTb3VyY2U9YWRtaW4="
#"bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQHJlbGVhc2UtbmFtZS1kYXRhYmFzZToyNzAxNy9ndWVzdGJvb2s/YXV0aFNvdXJjZT1hZG1pbg=="
---
# Source: guestbook/charts/database/templates/mongodb-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: release-name-database-secret
data:
  mongodb-username: YWRtaW4=
  mongodb-password: cGFzc3dvcmQ=
---
# Source: guestbook/charts/frontend/templates/frontend-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: release-name-frontend-config
data:
  guestbook-name: MyPopRock Festival 2.0
  backend-uri: http://backend.minikube.local/guestbook
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume.yaml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: release-name-database-pv
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path:  /mnt/data/release-name
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume-claim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: release-name-database-pvc
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
    name: release-name-backend
  name: release-name-backend
spec:
  type: ClusterIP
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 3000
  selector:
    app: release-name-backend
 # type: NodePort
---
# Source: guestbook/charts/database/templates/mongodb-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: release-name-database
  name: release-name-database
spec:
  ports:
    - name: mongodb
      port: 27017
      targetPort: 27017
  selector:
    app: release-name-database
#  type: NodePort
---
# Source: guestbook/charts/frontend/templates/frontend-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: release-name-frontend
  name: release-name-frontend
spec:
  type: ClusterIP
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 4200
  selector:
    app: release-name-frontend
---
# Source: guestbook/charts/backend/templates/backend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: release-name-backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: release-name-backend
  template:
    metadata:
      labels:
        app: release-name-backend
    spec:
      containers:
      - image: phico/backend:2.0
        imagePullPolicy: Always
        name: release-name-backend
        ports:
        - name: http
          containerPort: 3000
        env:
        - name: MONGODB_URI
          valueFrom:
            secretKeyRef:
              name: release-name-backend-secret
              key: mongodb-uri
---
# Source: guestbook/charts/database/templates/mongodb.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: release-name-database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: release-name-database
  template:
    metadata:
      labels:
        app: release-name-database
    spec:
      containers:
        - image: mongo
          env:
          - name: MONGO_INITDB_DATABASE
            value: guestbook
          - name: MONGO_INITDB_ROOT_USERNAME
            valueFrom:
              secretKeyRef:
                name: release-name-database-secret
                key: mongodb-username
          - name: MONGO_INITDB_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: release-name-database-secret
                key: mongodb-password
          name: release-name-database
          ports:
            - name: mongodb
              containerPort: 27017
          volumeMounts:
            - name: release-name-database-volume
              mountPath: /data/db
      volumes:
        - name: release-name-database-volume
          persistentVolumeClaim:
            claimName: release-name-database-pvc
---
# Source: guestbook/charts/frontend/templates/frontend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: release-name-frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: release-name-frontend 
  template:
    metadata:
      labels:
        app: release-name-frontend
    spec:
      containers:
      - image: phico/frontend:2.0
        imagePullPolicy: Always
        name: release-name-frontend
        ports:
        - name: http
          containerPort: 4200
        env:
        - name: BACKEND_URI
          valueFrom:
            configMapKeyRef:
              name: release-name-frontend-config
              key: backend-uri
        - name: GUESTBOOK_NAME
          valueFrom:
            configMapKeyRef:
              name: release-name-frontend-config
              key: guestbook-name
---
# Source: guestbook/charts/backend/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: release-name-backend-ingress
spec:
  rules:
  - host: backend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: release-name-backend
            port: 
              number: 80
---
# Source: guestbook/charts/frontend/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: release-name-frontend-ingress
spec:
  rules:
  - host: forntend.minikube.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: release-name-frontend
            port: 
              number: 80
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 5.helpers % 






bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 5.helpers % helm install demo-guestbook guestbook --dry-run --debug
install.go:178: [debug] Original chart version: ""
install.go:195: [debug] CHART PATH: /Users/bahrathkumaraju/external/whatishelm/kubernetes-packaging-applications-helm/demos_all/bharath_practise/5.helpers/guestbook

NAME: demo-guestbook
LAST DEPLOYED: Sat Jun 18 15:39:20 2022
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

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 5.helpers % 

