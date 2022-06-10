bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm install mysql stable/mysql                  
WARNING: This chart is deprecated
NAME: mysql
LAST DEPLOYED: Fri Jun 10 07:54:44 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
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

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % echo $MYSQL_ROOT_PASSWORD 
8jU098nlfP
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm list
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
mysql   default         1               2022-06-10 07:54:44.900307 +0800 +08    deployed        mysql-1.6.9     5.7.30     
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % kubectl get all
NAME                         READY   STATUS             RESTARTS   AGE
pod/mysql-7d99c88454-c6vj9   0/1     ImagePullBackOff   0          5m16s
pod/ubuntu                   0/1     Error              0          3m46s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP    2d15h
service/mysql        ClusterIP   10.111.8.45   <none>        3306/TCP   5m16s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql   0/1     1            0           5m16s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/mysql-7d99c88454   1         1         0       5m16s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


