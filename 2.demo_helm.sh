bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm search repo stable/mysql
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
stable/mysql            1.6.9           5.7.30          DEPRECATED - Fast, reliable, scalable, and easy...
stable/mysqldump        2.6.2           2.4.1           DEPRECATED! - A Helm chart to help backup MySQL...
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo list
NAME    URL                          
stable  https://charts.helm.sh/stable
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo add stable https://charts.helm.sh/stable
"stable" already exists with the same configuration, skipping
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo list
NAME    URL                          
stable  https://charts.helm.sh/stable
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm search repo stable/mysql
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
stable/mysql            1.6.9           5.7.30          DEPRECATED - Fast, reliable, scalable, and easy...
stable/mysqldump        2.6.2           2.4.1           DEPRECATED! - A Helm chart to help backup MySQL...
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 

