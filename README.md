# whatishelm
learn helm charts


### helm3 stores all manifests as secrets one way to decode and see is as below.

```
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$ kubectl get secrets sh.helm.release.v1.demo-guestbook.v4  -o jsonpath="{ .data.release }" | base64 -d | base64 -d | gunzip | json_pp
{
   "chart" : {
      "files" : null,
      "lock" : null,
      "metadata" : {
         "apiVersion" : "v2",
         "appVersion" : "2.0",
         "description" : "A helm chart for Guestbook 2.0",
         "name" : "guestbook",
         "type" : "application",
         "version" : "1.1.0"
      },
      "schema" : null,
      "templates" : null,
      "values" : null
   },
   "info" : {
      "deleted" : "",
      "description" : "Upgrade complete",
      "first_deployed" : "2022-06-16T07:52:51.45521+08:00",
      "last_deployed" : "2022-06-16T08:42:43.593627+08:00",
      "status" : "deployed"
   },
   "manifest" : "---\n# Source: guestbook/charts/backend/templates/backend-secret.yaml\napiVersion: v1\nkind: Secret\nmetadata:\n  name: backend-secret\ndata:\n  mongodb-uri: bW9uZ29kYjovL2FkbWluOnBhc3N3b3JkQG1vbmdvZGI6MjcwMTcvZ3Vlc3Rib29rP2F1dGhTb3VyY2U9YWRtaW4=\n---\n# Source: guestbook/charts/database/templates/mongodb-secret.yaml\napiVersion: v1\nkind: Secret\nmetadata:\n  name: mongodb-secret\ndata:\n  mongodb-username: YWRtaW4=\n  mongodb-password: cGFzc3dvcmQ=\n---\n# Source: guestbook/charts/frontend/templates/frontend-configmap.yaml\napiVersion: v1\nkind: ConfigMap\nmetadata:\n  name: frontend-config\ndata:\n  guestbook-name: \"MyPopRock Festival 2.0\"\n  backend-uri: \"http://backend.minikube.local/guestbook\"\n---\n# Source: guestbook/charts/database/templates/mongodb-persistent-volume.yaml\nkind: PersistentVolume\napiVersion: v1\nmetadata:\n  name: mongodb-pv-volume\n  labels:\n    type: local\nspec:\n  storageClassName: manual\n  capacity:\n    storage: 100Mi \n  accessModes:\n    - ReadWriteOnce\n  hostPath:\n    path:  /mnt/data\n---\n# Source: guestbook/charts/database/templates/mongodb-persistent-volume-claim.yaml\napiVersion: v1\nkind: PersistentVolumeClaim\nmetadata:\n  name: mongodb-pvc\nspec:\n  storageClassName: manual\n  accessModes:\n    - ReadWriteOnce\n  resources:\n    requests:\n      storage: 100Mi\n---\n# Source: guestbook/charts/backend/templates/backend-service.yaml\napiVersion: v1\nkind: Service\nmetadata:\n  labels:\n    name: backend\n  name: backend\nspec:\n  ports:\n    - protocol: \"TCP\"\n      port: 80\n      targetPort: 3000\n  selector:\n    app: backend\n # type: NodePort\n---\n# Source: guestbook/charts/database/templates/mongodb-service.yaml\napiVersion: v1\nkind: Service\nmetadata:\n  labels:\n    name: mongodb\n  name: mongodb\nspec:\n  ports:\n    - name: mongodb\n      port: 27017\n      targetPort: 27017\n  selector:\n    app: mongodb\n  type: NodePort\n---\n# Source: guestbook/charts/frontend/templates/frontend-service.yaml\napiVersion: v1\nkind: Service\nmetadata:\n  labels:\n    name: frontend\n  name: frontend\nspec:\n  ports:\n    - protocol: \"TCP\"\n      port: 80\n      targetPort: 4200\n  selector:\n    app: frontend\n---\n# Source: guestbook/charts/backend/templates/backend.yaml\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: backend\nspec:\n  replicas: 1\n  selector:\n    matchLabels:\n      app: backend \n  template:\n    metadata:\n      labels:\n        app: backend\n    spec:\n      containers:\n      - image: phico/backend:2.0\n        imagePullPolicy: Always\n        name: backend\n        ports:\n        - name: backend\n          containerPort: 3000\n        env:\n        - name: MONGODB_URI\n          valueFrom:\n            secretKeyRef:\n              name: backend-secret\n              key: mongodb-uri\n---\n# Source: guestbook/charts/database/templates/mongodb.yaml\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: mongodb\nspec:\n  replicas: 1\n  selector:\n    matchLabels:\n      app: mongodb\n  template:\n    metadata:\n      labels:\n        app: mongodb\n    spec:\n      containers:\n        - image: mongo\n          env:\n          - name: MONGO_INITDB_DATABASE\n            value: guestbook\n          - name: MONGO_INITDB_ROOT_USERNAME\n            valueFrom:\n              secretKeyRef:\n                name: mongodb-secret\n                key: mongodb-username\n          - name: MONGO_INITDB_ROOT_PASSWORD\n            valueFrom:\n              secretKeyRef:\n                name: mongodb-secret\n                key: mongodb-password\n          name: mongodb\n          ports:\n            - name: mongodb\n              containerPort: 27017\n          volumeMounts:\n            - name: mongodb-volume\n              mountPath: /data/db\n      volumes:\n        - name: mongodb-volume\n          persistentVolumeClaim:\n            claimName: mongodb-pvc\n---\n# Source: guestbook/charts/frontend/templates/frontend.yaml\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: frontend\nspec:\n  replicas: 1\n  selector:\n    matchLabels:\n      app: frontend \n  template:\n    metadata:\n      labels:\n        app: frontend\n    spec:\n      containers:\n      - image: phico/frontend:2.0\n        imagePullPolicy: Always\n        name: frontend\n        ports:\n        - name: frontend\n          containerPort: 4200\n        env:\n        - name: BACKEND_URI\n          valueFrom:\n            configMapKeyRef:\n              name: frontend-config\n              key: backend-uri\n        - name: GUESTBOOK_NAME\n          valueFrom:\n            configMapKeyRef:\n              name: frontend-config\n              key: guestbook-name\n---\n# Source: guestbook/charts/frontend/templates/ingress.yaml\napiVersion: networking.k8s.io/v1\nkind: Ingress\nmetadata:\n  name: guestbook-ingress\nspec:\n  rules:\n  - host: frontend.minikube.local\n    http:\n      paths:\n      - path: /\n        pathType: Prefix\n        backend:\n          service:\n            name: frontend\n            port: \n              number: 80\n  - host: backend.minikube.local\n    http:\n      paths:\n      - path: /\n        pathType: Prefix\n        backend:\n          service:\n            name: backend\n            port: \n              number: 80\n",
   "name" : "demo-guestbook",
   "namespace" : "default",
   "version" : 4
}
Bahrathkumarajus-MacBook-Pro:2.lab bahrathkumaraju$
```


## api-resources and api-versions

```
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl api-resources | grep -i replica
replicationcontrollers            rc                                          true         ReplicationController
replicasets                       rs           apps                           true         ReplicaSet
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl api-versions | grep -i apps
apps/v1
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

```