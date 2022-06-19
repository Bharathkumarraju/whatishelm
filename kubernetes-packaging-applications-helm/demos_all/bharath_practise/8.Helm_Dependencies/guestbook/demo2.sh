helm dependency update guestbook 
helm dependency list guestbook 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % helm dependency update guestbook
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
Downloading database from repo http://localhost:8080
Deleting outdated charts
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % helm dependency list guestbook
NAME            VERSION REPOSITORY              STATUS
backend         ~0.1.0  http://localhost:8080   ok    
frontend        ~1.1.0  http://localhost:8080   ok    
database        ~0.1.0  http://localhost:8080   ok    

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % helm install dev guestbook
NAME: dev
LAST DEPLOYED: Mon Jun 20 07:45:59 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Congratulations ! You installed guestbook chart sucessfully.
Release name is dev

You can access the Guestbook application at the following urls :
  http://dev.frontend.minikube.local
  http://dev.backend.minikube.local
Have fun !
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 8.Helm_Dependencies % 


