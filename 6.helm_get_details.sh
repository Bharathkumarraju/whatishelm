bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm get values mysql
USER-SUPPLIED VALUES:
null
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm %



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm get notes mysql
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


