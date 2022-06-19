helm package chart_name

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % helm list -a
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
dev     default         1               2022-06-19 09:36:30.510841 +0800 +08    deployed        guestbook-1.1.0 2.0        
test    default         1               2022-06-19 09:43:37.876083 +0800 +08    deployed        guestbook-1.1.0 2.0        
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro whatishelm % 

helm repo index .
helm package --sign 
helm verify chart.tgz
helm install --verify 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 7.Helm_dependencies % cd dist
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % helm package frontend backend database 
Successfully packaged chart and saved it to: /Users/bahrathkumaraju/external/whatishelm/kubernetes-packaging-applications-helm/demos_all/bharath_practise/7.Helm_dependencies/dist/frontend-1.1.0.tgz
Successfully packaged chart and saved it to: /Users/bahrathkumaraju/external/whatishelm/kubernetes-packaging-applications-helm/demos_all/bharath_practise/7.Helm_dependencies/dist/backend-0.1.0.tgz
Successfully packaged chart and saved it to: /Users/bahrathkumaraju/external/whatishelm/kubernetes-packaging-applications-helm/demos_all/bharath_practise/7.Helm_dependencies/dist/database-0.1.0.tgz
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % 

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % ls -rtlh
total 24
drwxr-xr-x  5 bahrathkumaraju  staff   160B 19 Jun 13:47 backend
drwxr-xr-x  5 bahrathkumaraju  staff   160B 19 Jun 13:47 database
drwxr-xr-x  5 bahrathkumaraju  staff   160B 19 Jun 13:47 frontend
-rw-r--r--  1 bahrathkumaraju  staff   1.1K 19 Jun 13:47 frontend-1.1.0.tgz
-rw-r--r--  1 bahrathkumaraju  staff   1.3K 19 Jun 13:47 backend-0.1.0.tgz
-rw-r--r--  1 bahrathkumaraju  staff   1.2K 19 Jun 13:47 database-0.1.0.tgz
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % helm repo index .


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % ls -lrth
total 32
drwxr-xr-x  5 bahrathkumaraju  staff   160B 19 Jun 13:47 backend
drwxr-xr-x  5 bahrathkumaraju  staff   160B 19 Jun 13:47 database
drwxr-xr-x  5 bahrathkumaraju  staff   160B 19 Jun 13:47 frontend
-rw-r--r--  1 bahrathkumaraju  staff   1.1K 19 Jun 13:47 frontend-1.1.0.tgz
-rw-r--r--  1 bahrathkumaraju  staff   1.3K 19 Jun 13:47 backend-0.1.0.tgz
-rw-r--r--  1 bahrathkumaraju  staff   1.2K 19 Jun 13:47 database-0.1.0.tgz
-rw-r--r--  1 bahrathkumaraju  staff   1.0K 19 Jun 13:49 index.yaml
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % cat index.yaml 
apiVersion: v1
entries:
  backend:
  - apiVersion: v2
    appVersion: "1.0"
    created: "2022-06-19T13:49:38.436533+08:00"
    description: A helm chart for Backend 1.0
    digest: 03c7dddeabc2c6eb010ac49e62254511ba7fc4b1e1c25b284ea2b0ecb1165ff2
    name: backend
    type: application
    urls:
    - backend-0.1.0.tgz
    version: 0.1.0
  database:
  - apiVersion: v2
    appVersion: "3.6"
    created: "2022-06-19T13:49:38.436727+08:00"
    description: A helm chart for Guestbook Database Mongodb 3.6
    digest: 3e5f1bab35dd84b501183347d1c51e4b41f6d7bcea70c7e0f3770e1f25e444ea
    name: database
    type: application
    urls:
    - database-0.1.0.tgz
    version: 0.1.0
  frontend:
  - apiVersion: v2
    appVersion: "2.0"
    created: "2022-06-19T13:49:38.436929+08:00"
    description: A helm chart for Frontend 2.0
    digest: bd419ae3d96836114795a21ef438b76b73d12c510818188906e9ece9d494a266
    name: frontend
    type: application
    urls:
    - frontend-1.1.0.tgz
    version: 1.1.0
generated: "2022-06-19T13:49:38.435977+08:00"
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % 


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % mkdir ~/helm/repo
mkdir: /Users/bahrathkumaraju/helm: No such file or directory
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % mkdir -p ~/helm/repo
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % chartmuseum
2022-06-19 20:37:13.309769 I | Missing required flags(s): --storage
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % chartmuseum --storage="local" --storage-local-rootdir=/Users/bahrathkumaraju/helm/repo 
2022-06-19T20:38:51.481+0800    INFO    Starting ChartMuseum    {"host": "0.0.0.0", "port": 8080}
2022-06-20T06:14:48.730+0800    INFO    [1] Request served      {"path": "/", "comment": "", "clientIP": "::1", "method": "GET", "statusCode": 200, "latency": "2.775959ms", "reqID": "a9d128c8-0545-4810-8ac7-8d55407bca01"}
2022-06-20T06:14:48.852+0800    WARN    [2] Request served      {"path": "/favicon.ico", "comment": "", "clientIP": "::1", "method": "GET", "statusCode": 404, "latency": "1.136459ms", "reqID": "37a97375-617c-40f2-85a0-6bb8992729db"}


bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % curl http://localhost:8080/api/charts | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   963  100   963    0     0  16647      0 --:--:-- --:--:-- --:--:-- 34392
{
  "backend": [
    {
      "name": "backend",
      "version": "0.1.0",
      "description": "A helm chart for Backend 1.0",
      "apiVersion": "v2",
      "appVersion": "1.0",
      "type": "application",
      "urls": [
        "charts/backend-0.1.0.tgz"
      ],
      "created": "2022-06-20T06:17:35.366255978+08:00",
      "digest": "03c7dddeabc2c6eb010ac49e62254511ba7fc4b1e1c25b284ea2b0ecb1165ff2"
    }
  ],
  "database": [
    {
      "name": "database",
      "version": "0.1.0",
      "description": "A helm chart for Guestbook Database Mongodb 3.6",
      "apiVersion": "v2",
      "appVersion": "3.6",
      "type": "application",
      "urls": [
        "charts/database-0.1.0.tgz"
      ],
      "created": "2022-06-20T06:17:35.366791891+08:00",
      "digest": "3e5f1bab35dd84b501183347d1c51e4b41f6d7bcea70c7e0f3770e1f25e444ea"
    }
  ],
  "frontend": [
    {
      "name": "frontend",
      "version": "1.1.0",
      "description": "A helm chart for Frontend 2.0",
      "apiVersion": "v2",
      "appVersion": "2.0",
      "type": "application",
      "urls": [
        "charts/frontend-1.1.0.tgz"
      ],
      "created": "2022-06-20T06:17:35.367095389+08:00",
      "digest": "bd419ae3d96836114795a21ef438b76b73d12c510818188906e9ece9d494a266"
    }
  ]
}
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro dist % 


