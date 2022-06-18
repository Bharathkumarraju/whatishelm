bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 4.loops % helm install demo-bkloops bkloops --dry-run --debug
install.go:178: [debug] Original chart version: ""
install.go:195: [debug] CHART PATH: /Users/bahrathkumaraju/external/whatishelm/kubernetes-packaging-applications-helm/demos_all/bharath_practise/4.loops/bkloops

NAME: demo-bkloops
LAST DEPLOYED: Fri Jun 17 11:09:57 2022
NAMESPACE: default
STATUS: pending-install
REVISION: 1
TEST SUITE: None
USER-SUPPLIED VALUES:
{}

COMPUTED VALUES:
frontend:
  global: {}
  ingress:
    hosts:
    - hostname: forntend.local
      paths:
      - path: /public
        service: frotend
      - path: /admin
        service: admin
    - hostname: backend.local
      paths:
      - path: /db
        service: backend-db
      - path: /cache
        service: redis-cache

HOOKS:
MANIFEST:
---
# Source: bkloops/charts/frontend/templates/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-bkloops-frontend-ingress
spec:
  rules:
      - host: "forntend.local"
        http:
          paths:
            - path: /public
              pathType: prefix
              backend:
                service:
                  name:  frotend
            - path: /admin
              pathType: prefix
              backend:
                service:
                  name:  admin

      - host: "backend.local"
        http:
          paths:
            - path: /db
              pathType: prefix
              backend:
                service:
                  name:  backend-db
            - path: /cache
              pathType: prefix
              backend:
                service:
                  name:  redis-cache

bahrathkumaraju@Bahrathkumarajus-MacBook-Pro 4.loops %