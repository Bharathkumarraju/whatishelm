helm dependency update guestbook 
helm dependency list guestbook 

Chart.yaml (or) requirements.yaml(for Heml2)
Chart.lock
helm dependency build guestbook


helm install demo guestbook --set database.enabled=true 
helm install demo guestbook --set tags.api=false


conditions and tags:
------------------------>
conditions override tags 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo add chartmuseum http://localhost:8080
"chartmuseum" has been added to your repositories
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm %

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo list
NAME                    URL                                                                  
Bharathkumarraju        https://raw.githubusercontent.com/Bharathkumarraju/demohelmrepo/main/
tyk-helm                https://helm.tyk.io/public/helm/charts/                              
bitnami                 https://charts.bitnami.com/bitnami                                   
stable                  https://charts.helm.sh/stable                                        
chartmuseum             http://localhost:8080                                                
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "chartmuseum" chart repository
...Successfully got an update from the "Bharathkumarraju" chart repository
...Successfully got an update from the "tyk-helm" chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm search repo chartmuseum 
NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                    
stable/chartmuseum      2.14.2          0.12.0          DEPRECATED Host your own Helm Chart Repository 
chartmuseum/backend     0.1.0           1.0             A helm chart for Backend 1.0                   
chartmuseum/database    0.1.0           3.6             A helm chart for Guestbook Database Mongodb 3.6
chartmuseum/frontend    1.1.0           2.0             A helm chart for Frontend 2.0                  
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 


