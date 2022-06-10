bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % helm create bkchart
Creating bkchart
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % ls -larth
total 24
-rw-r--r--   1 bahrathkumaraju  staff   1.1K 10 Jun 09:03 Chart.yaml
-rw-r--r--   1 bahrathkumaraju  staff   1.8K 10 Jun 09:03 values.yaml
-rw-r--r--   1 bahrathkumaraju  staff   349B 10 Jun 09:03 .helmignore
drwxr-xr-x  10 bahrathkumaraju  staff   320B 10 Jun 09:03 templates
drwxr-xr-x   2 bahrathkumaraju  staff    64B 10 Jun 09:03 charts
drwxr-xr-x   7 bahrathkumaraju  staff   224B 10 Jun 09:03 .
drwxr-xr-x   4 bahrathkumaraju  staff   128B 10 Jun 09:03 ..
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % kubectl create deployment nginx --image=nginx --dry-run=client -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % kubectl create deployment nginx --image=nginx
deployment.apps/nginx created
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % kubectl expose deployment nginx --type=LoadBalancer --port=80 --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: nginx
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  type: LoadBalancer
status:
  loadBalancer: {}
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % kubectl expose deployment nginx --type=LoadBalancer --port=80 --dry-run=client -o yaml > templates/service.yaml
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro bkchart % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % helm install bkchart ./bkchart 
NAME: bkchart
LAST DEPLOYED: Fri Jun 10 09:14:14 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro custom_charts % 


