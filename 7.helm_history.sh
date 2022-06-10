bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm history mysql
REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION     
1               Fri Jun 10 07:54:44 2022        deployed        mysql-1.6.9     5.7.30          Install complete
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm uninstall mysql --keep-history
release "mysql" uninstalled
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm history mysql                 
REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION            
1               Fri Jun 10 07:54:44 2022        uninstalled     mysql-1.6.9     5.7.30          Uninstallation complete
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm list
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm list --all
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
mysql   default         1               2022-06-10 07:54:44.900307 +0800 +08    uninstalled     mysql-1.6.9     5.7.30     
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm delete mysql
release "mysql" uninstalled
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm list --all  
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 




