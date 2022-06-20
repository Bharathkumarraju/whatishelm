helm repo list

helm search repo stable/mongo

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm search repo stable/mongo
NAME                            CHART VERSION   APP VERSION     DESCRIPTION                                       
stable/mongodb                  7.8.10          4.2.4           DEPRECATED NoSQL document-oriented database tha...
stable/mongodb-replicaset       3.17.2          3.6             DEPRECATED - NoSQL document-oriented database t...
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 



bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 9.Helm_use_existing_stable_charts % helm dependency update guestbook
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "chartmuseum" chart repository
...Successfully got an update from the "Bharathkumarraju" chart repository
...Successfully got an update from the "tyk-helm" chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 3 charts
Downloading backend from repo http://localhost:8080
Downloading frontend from repo http://localhost:8080
Downloading mongodb from repo https://charts.bitnami.com/bitnami
Deleting outdated charts
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 9.Helm_use_existing_stable_charts % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 9.Helm_use_existing_stable_charts % helm dependency list guestbook
NAME            VERSION REPOSITORY                              STATUS
backend         ~0.1.0  http://localhost:8080                   ok    
frontend        ^1.1.0  http://localhost:8080                   ok    
mongodb         12.1.x  https://charts.bitnami.com/bitnami      ok    

WARNING: "guestbook/charts/database" is not in Chart.yaml.
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 9.Helm_use_existing_stable_charts % 

