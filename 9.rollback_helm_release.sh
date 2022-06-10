bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm history mysql
REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION     
1               Fri Jun 10 08:42:56 2022        superseded      mysql-1.6.3     5.7.28          Install complete
2               Fri Jun 10 08:43:53 2022        superseded      mysql-1.6.3     5.7.28          Upgrade complete
3               Fri Jun 10 08:43:59 2022        superseded      mysql-1.6.5     5.7.30          Upgrade complete
4               Fri Jun 10 08:44:05 2022        deployed        mysql-1.6.7     5.7.30          Upgrade complete
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm rollback mysql 3
Rollback was a success! Happy Helming!
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm history mysql   
REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION     
1               Fri Jun 10 08:42:56 2022        superseded      mysql-1.6.3     5.7.28          Install complete
2               Fri Jun 10 08:43:53 2022        superseded      mysql-1.6.3     5.7.28          Upgrade complete
3               Fri Jun 10 08:43:59 2022        superseded      mysql-1.6.5     5.7.30          Upgrade complete
4               Fri Jun 10 08:44:05 2022        superseded      mysql-1.6.7     5.7.30          Upgrade complete
5               Fri Jun 10 08:49:07 2022        deployed        mysql-1.6.5     5.7.30          Rollback to 3   
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % kubectl get all
NAME                         READY   STATUS             RESTARTS   AGE
pod/mysql-6f5bdc79d6-8djnt   0/1     ImagePullBackOff   0          82s

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    2d16h
service/mysql        ClusterIP   10.104.210.201   <none>        3306/TCP   7m34s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql   0/1     1            0           7m34s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/mysql-595fc8486b   0         0         0       7m34s
replicaset.apps/mysql-6f5bdc79d6   1         1         0       6m27s
replicaset.apps/mysql-7d99c88454   0         0         0       6m16s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % kubectl get secrets
NAME                          TYPE                                  DATA   AGE
default-token-2q4pd           kubernetes.io/service-account-token   3      2d16h
mysql                         Opaque                                2      9m1s
sh.helm.release.v1.mysql.v1   helm.sh/release.v1                    1      9m1s
sh.helm.release.v1.mysql.v2   helm.sh/release.v1                    1      8m4s
sh.helm.release.v1.mysql.v3   helm.sh/release.v1                    1      7m58s
sh.helm.release.v1.mysql.v4   helm.sh/release.v1                    1      7m51s
sh.helm.release.v1.mysql.v5   helm.sh/release.v1                    1      2m50s
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


