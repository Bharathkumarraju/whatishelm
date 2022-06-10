bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm search repo stable/mysql
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
stable/mysql            1.6.9           5.7.30          DEPRECATED - Fast, reliable, scalable, and easy...
stable/mysqldump        2.6.2           2.4.1           DEPRECATED! - A Helm chart to help backup MySQL...
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm show chart stable/mysql
apiVersion: v1
appVersion: 5.7.30
deprecated: true
description: DEPRECATED - Fast, reliable, scalable, and easy to use open-source relational
  database system.
home: https://www.mysql.com/
icon: https://www.mysql.com/common/logos/logo-mysql-170x115.png
keywords:
- mysql
- database
- sql
name: mysql
sources:
- https://github.com/kubernetes/charts
- https://github.com/docker-library/mysql
version: 1.6.9

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm install mysql stable/mysql --dry-run --debug
install.go:178: [debug] Original chart version: ""
install.go:195: [debug] CHART PATH: /Users/bahrathkumaraju/Library/Caches/helm/repository/mysql-1.6.9.tgz

WARNING: This chart is deprecated
NAME: mysql
LAST DEPLOYED: Fri Jun 10 07:52:58 2022
NAMESPACE: default
STATUS: pending-install
REVISION: 1
USER-SUPPLIED VALUES:
{}

COMPUTED VALUES:
affinity: {}
args: []
busybox:
  image: busybox
  tag: "1.32"
configurationFiles: {}
configurationFilesPath: /etc/mysql/conf.d/
deploymentAnnotations: {}
extraInitContainers: |
  # - name: do-something
  #   image: busybox
  #   command: ['do', 'something']
extraVolumeMounts: |
  # - name: extras
  #   mountPath: /usr/share/extras
  #   readOnly: true
extraVolumes: |
  # - name: extras
  #   emptyDir: {}
image: mysql
imagePullPolicy: IfNotPresent
imageTag: 5.7.30
initContainer:
  resources:
    requests:
      cpu: 10m
      memory: 10Mi
initializationFiles: {}
livenessProbe:
  failureThreshold: 3
  initialDelaySeconds: 30
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 5
metrics:
  annotations: {}
  enabled: false
  flags: []
  image: prom/mysqld-exporter
  imagePullPolicy: IfNotPresent
  imageTag: v0.10.0
  livenessProbe:
    initialDelaySeconds: 15
    timeoutSeconds: 5
  readinessProbe:
    initialDelaySeconds: 5
    timeoutSeconds: 1
  resources: {}
  serviceMonitor:
    additionalLabels: {}
    enabled: false
mysqlx:
  port:
    enabled: false
nodeSelector: {}
persistence:
  accessMode: ReadWriteOnce
  annotations: {}
  enabled: true
  size: 8Gi
podAnnotations: {}
podLabels: {}
readinessProbe:
  failureThreshold: 3
  initialDelaySeconds: 5
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 1
resources:
  requests:
    cpu: 100m
    memory: 256Mi
securityContext:
  enabled: false
  fsGroup: 999
  runAsUser: 999
service:
  annotations: {}
  port: 3306
  type: ClusterIP
serviceAccount:
  create: false
ssl:
  certificates: null
  enabled: false
  secret: mysql-ssl-certs
strategy:
  type: Recreate
testFramework:
  enabled: true
  image: bats/bats
  imagePullPolicy: IfNotPresent
  securityContext: {}
  tag: 1.2.1
tolerations: []

HOOKS:
---
# Source: mysql/templates/tests/test.yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql-test
  namespace: default
  labels:
    app: mysql
    chart: "mysql-1.6.9"
    heritage: "Helm"
    release: "mysql"
  annotations:
    "helm.sh/hook": test-success
spec:
  containers:
    - name: mysql-test
      image: "bats/bats:1.2.1"
      imagePullPolicy: "IfNotPresent"
      command: ["/opt/bats/bin/bats", "-t", "/tests/run.sh"]
      volumeMounts:
      - mountPath: /tests
        name: tests
        readOnly: true
  volumes:
  - name: tests
    configMap:
      name: mysql-test
  restartPolicy: Never
MANIFEST:
---
# Source: mysql/templates/secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql
  namespace: default
  labels:
    app: mysql
    chart: "mysql-1.6.9"
    release: "mysql"
    heritage: "Helm"
type: Opaque
data:
  
  
  mysql-root-password: "Uk5xcGtOSk55ag=="
  
  
  
  
  mysql-password: "aE1FcmQwckNTTg=="
---
# Source: mysql/templates/tests/test-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-test
  namespace: default
  labels:
    app: mysql
    chart: "mysql-1.6.9"
    heritage: "Helm"
    release: "mysql"
data:
  run.sh: |-
---
# Source: mysql/templates/pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mysql
  namespace: default
  labels:
    app: mysql
    chart: "mysql-1.6.9"
    release: "mysql"
    heritage: "Helm"
spec:
  accessModes:
    - "ReadWriteOnce"
  resources:
    requests:
      storage: "8Gi"
---
# Source: mysql/templates/svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
  namespace: default
  labels:
    app: mysql
    chart: "mysql-1.6.9"
    release: "mysql"
    heritage: "Helm"
  annotations:
spec:
  type: ClusterIP
  ports:
  - name: mysql
    port: 3306
    targetPort: mysql
  selector:
    app: mysql
---
# Source: mysql/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  namespace: default
  labels:
    app: mysql
    chart: "mysql-1.6.9"
    release: "mysql"
    heritage: "Helm"

spec:
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: mysql
      release: mysql
  template:
    metadata:
      labels:
        app: mysql
        release: mysql
    spec:
      serviceAccountName: default
      initContainers:
      - name: "remove-lost-found"
        image: "busybox:1.32"
        imagePullPolicy: "IfNotPresent"
        resources:
          requests:
            cpu: 10m
            memory: 10Mi
        command:  ["rm", "-fr", "/var/lib/mysql/lost+found"]
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql
      # - name: do-something
      #   image: busybox
      #   command: ['do', 'something']
      
      containers:
      - name: mysql
        image: "mysql:5.7.30"
        imagePullPolicy: "IfNotPresent"
        resources:
          requests:
            cpu: 100m
            memory: 256Mi
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql
              key: mysql-root-password
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql
              key: mysql-password
              optional: true
        - name: MYSQL_USER
          value: ""
        - name: MYSQL_DATABASE
          value: ""
        ports:
        - name: mysql
          containerPort: 3306
        livenessProbe:
          exec:
            command:
            - sh
            - -c
            - "mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD}"
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
        readinessProbe:
          exec:
            command:
            - sh
            - -c
            - "mysqladmin ping -u root -p${MYSQL_ROOT_PASSWORD}"
          initialDelaySeconds: 5
          periodSeconds: 10
          timeoutSeconds: 1
          successThreshold: 1
          failureThreshold: 3
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql
        # - name: extras
        #   mountPath: /usr/share/extras
        #   readOnly: true
        
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: mysql
      # - name: extras
      #   emptyDir: {}

NOTES:
MySQL can be accessed via port 3306 on the following DNS name from within your cluster:
mysql.default.svc.cluster.local

To get your root password run:

    MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)

To connect to your database:

1. Run an Ubuntu pod that you can use as a client:

    kubectl run -i --tty ubuntu --image=ubuntu:16.04 --restart=Never -- bash -il

2. Install the mysql client:

    $ apt-get update && apt-get install mysql-client -y

3. Connect using the mysql cli, then provide your password:
    $ mysql -h mysql -p

To connect to your database directly from outside the K8s cluster:
    MYSQL_HOST=127.0.0.1
    MYSQL_PORT=3306

    # Execute the following command to route the connection:
    kubectl port-forward svc/mysql 3306

    mysql -h ${MYSQL_HOST} -P${MYSQL_PORT} -u root -p${MYSQL_ROOT_PASSWORD}
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm %
