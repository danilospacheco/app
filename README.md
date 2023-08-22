#Neste processo utilizarei o ingress do nginx, também é possível utilizar outros, como Istio ou Traefik

Procedimento ingress-nginx controller

Documentação de apoio:
https://kubernetes.github.io/ingress-nginx/deploy/

kubectl apply -f ingress-controller-nginx.yaml

Como eu não tenho um loadBalance para este procedimento, adicionei no campo “spec” a configuração externalIPs e assim utilizar o ip do meu cluster local como loadBalance. Infelizmente eu não adicionei um alias/dns no meu /etc/hosts por falta de permissão no notebook.

---------------

Procedimento Aplicação

Arquivo Dockerfile contendo as informações da imagem/aplicação.

docker build -t danilospacheco/app-danilo:v1 . --no-cache

Caso queira testar o container antes de subir no kubernetes é só executar o comando abaixo:
docker run -d --name nginx-danilo -it -p 80:8080 -p 443:4433 danilospacheco/app-danilo:latest

Os arquivos .yaml para o kubernetes encontram-se na pasta “app”, é possível executar todos de uma vez
kubectl apply -f ../app
Para remover: kubectl delete -f ../app --force


Através do Helm também é possível efetuar o deploy
helm upgrade --install app-danilo .
Para remover: kubectl delete -f ../app --force


---------------

kubectl create namespace argocd kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml watch kubectl get pods -n argocd kubectl port-forward svc/argocd-server -n argocd 8080:443 ou configurar o service como “NodePort”

coletar a senha de acesso kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo