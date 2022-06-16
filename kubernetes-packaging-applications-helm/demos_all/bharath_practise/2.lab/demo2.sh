Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ helm get manifest demo-guestbook
---
# Source: guestbook/charts/backend/templates/backend-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: backend-secret
data:
  mongodb-uri: bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQG1vbmdvZGI6MjcwMTcvZ3Vlc3Rib29rP2F1dGhTb3VyY2U9YWRtaW4=
---
# Source: guestbook/charts/database/templates/mongodb-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: mongodb-secret
data:
  mongodb-username: YWRtaW4=
  mongodb-password: cGFzc3dvcmQ=
---
# Source: guestbook/charts/frontend/templates/frontend-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: frontend-config
data:
  guestbook-name: "MyPopRock Festival 2.0"
  backend-uri: "http://backend.minikube.local/guestbook"
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume.yaml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: mongodb-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 100Mi 
  accessModes:
    - ReadWriteOnce
  hostPath:
    path:  /mnt/data
---
# Source: guestbook/charts/database/templates/mongodb-persistent-volume-claim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongodb-pvc
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
    name: backend
  name: backend
spec:
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 3000
  selector:
    app: backend
 # type: NodePort
---
# Source: guestbook/charts/database/templates/mongodb-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: mongodb
  name: mongodb
spec:
  ports:
    - name: mongodb
      port: 27017
      targetPort: 27017
  selector:
    app: mongodb
  type: NodePort
---
# Source: guestbook/charts/frontend/templates/frontend-service.yaml
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
# Source: guestbook/charts/backend/templates/backend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend 
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - image: phico/backend:2.0
        imagePullPolicy: Always
        name: backend
        ports:
        - name: backend
          containerPort: 3000
        env:
        - name: MONGODB_URI
          valueFrom:
            secretKeyRef:
              name: backend-secret
              key: mongodb-uri
---
# Source: guestbook/charts/database/templates/mongodb.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
        - image: mongo
          env:
          - name: MONGO_INITDB_DATABASE
            value: guestbook
          - name: MONGO_INITDB_ROOT_USERNAME
            valueFrom:
              secretKeyRef:
                name: mongodb-secret
                key: mongodb-username
          - name: MONGO_INITDB_ROOT_PASSWORD
            valueFrom:
              secretKeyRef:
                name: mongodb-secret
                key: mongodb-password
          name: mongodb
          ports:
            - name: mongodb
              containerPort: 27017
          volumeMounts:
            - name: mongodb-volume
              mountPath: /data/db
      volumes:
        - name: mongodb-volume
          persistentVolumeClaim:
            claimName: mongodb-pvc
---
# Source: guestbook/charts/frontend/templates/frontend.yaml
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
      - image: phico/frontend:2.0
        imagePullPolicy: Always
        name: frontend
        ports:
        - name: frontend
          containerPort: 4200
        env:
        - name: BACKEND_URI
          valueFrom:
            configMapKeyRef:
              name: frontend-config
              key: backend-uri
        - name: GUESTBOOK_NAME
          valueFrom:
            configMapKeyRef:
              name: frontend-config
              key: guestbook-name
---
# Source: guestbook/charts/frontend/templates/ingress.yaml
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

Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$