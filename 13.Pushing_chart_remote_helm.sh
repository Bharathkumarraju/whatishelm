bahrathkumaraju@Bahrathkumarajus-MacBook-Pro external % cd demohelmrepo
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % ls -rtlh
total 88
-rw-r--r--  1 bahrathkumaraju  staff    34K Jun 10 12:24 LICENSE
-rw-r--r--  1 bahrathkumaraju  staff    30B Jun 10 12:24 README.md
-rw-r--r--  1 bahrathkumaraju  staff   1.4K Jun 10 12:37 bkchart-0.1.0.tgz
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % helm repo index .
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % ls -rtlh
total 96
-rw-r--r--  1 bahrathkumaraju  staff    34K Jun 10 12:24 LICENSE
-rw-r--r--  1 bahrathkumaraju  staff    30B Jun 10 12:24 README.md
-rw-r--r--  1 bahrathkumaraju  staff   1.4K Jun 10 12:37 bkchart-0.1.0.tgz
-rw-r--r--  1 bahrathkumaraju  staff   386B Jun 10 12:38 index.yaml
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % git status
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	bkchart-0.1.0.tgz
	index.yaml

nothing added to commit but untracked files present (use "git add" to track)
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % git add .
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % git commit -am "add chart to repo"
[main c78bcde] add chart to repo
 2 files changed, 14 insertions(+)
 create mode 100644 bkchart-0.1.0.tgz
 create mode 100644 index.yaml
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % git push origin main
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 2.01 KiB | 2.01 MiB/s, done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:Bharathkumarraju/demohelmrepo.git
   e5f0cdf..c78bcde  main -> main
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo % cat index.yaml
apiVersion: v1
entries:
  bkchart:
  - apiVersion: v2
    appVersion: 1.16.0
    created: "2022-06-10T12:38:11.440399+08:00"
    description: A Helm chart for Kubernetes
    digest: a90ad2886b6aa9ad0a827c9f2746c0003b2017878dcbba12072be6f0a9859a18
    name: bkchart
    type: application
    urls:
    - bkchart-0.1.0.tgz
    version: 0.1.0
generated: "2022-06-10T12:38:11.439926+08:00"
bahrathkumaraju@Bahrathkumarajus-MacBook-Pro demohelmrepo %


Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ helm repo add Bharathkumarraju https://raw.githubusercontent.com/Bharathkumarraju/demohelmrepo/main/
"Bharathkumarraju" has been added to your repositories
Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ 



Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ helm repo list
NAME                    URL                                                                  
stable                  https://charts.helm.sh/stable                                        
chartmuseum             http://127.0.0.1:8080/                                               
Bharathkumarraju        https://raw.githubusercontent.com/Bharathkumarraju/demohelmrepo/main/
Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ 

Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ helm search repo Bharathkumarraju/bkchart
NAME                            CHART VERSION   APP VERSION     DESCRIPTION                
bharathkumarraju/bkchart        0.1.0           1.16.0          A Helm chart for Kubernetes
Bahrathkumarajus-MacBook-Pro:custom_charts bahrathkumaraju$ 

