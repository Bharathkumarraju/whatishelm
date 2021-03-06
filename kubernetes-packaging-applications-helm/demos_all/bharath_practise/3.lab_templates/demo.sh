helm template chart 

helm install [release][chart] --dry-run --debug 2>&1 | less

Get all the values using the command i.e. $ helm get all demo(Releases Name)

global:
  id: 

  

  bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % helm template guestbook
---
# Source: guestbook/charts/backend/templates/backend-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: release-name-backend-secret
data:
  mongodb-uri: bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQG1vbmdvZGI6MjcwMTcvZ3Vlc3Rib29rP2F1dGhTb3VyY2U9YWRtaW4=
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
  type: NodePort
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
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: release-name-backend-ingress
spec:
  rules:
  - host: backend.minikube.local
    http:
      paths:
      - path: /
        backend:
          serviceName: release-name-backend
          servicePort: 80
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
        backend:
          serviceName: release-name-frontend
          servicePort: 80
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 3.lab_templates % 




