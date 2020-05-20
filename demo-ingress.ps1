#Creating namespace
kubectl create namespace demo-ingress

#install ingress controller
helm install nginx-ingress-demo stable/nginx-ingress --namespace demo-ingress --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

#Createing SSL Cert in current directory
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out C:\Learning\techDemo1\learn-terraform-provision-aks-cluster\aks-ingress-tls.crt -keyout C:\Learning\techDemo1\learn-terraform-provision-aks-cluster\aks-ingress-tls.key -subj "/CN=demo.azure.com/O=aks-ingress-tls"

#Adding certs as cluster secret
# kubectl create secret tls aks-ingress-tls --namespace demo-ingress --key aks-ingress-tls.key --cert aks-ingress-tls.crt
# kubectl create secret tls aks-ingress-tls --namespace demo-ingress --key aks-ingress-tls.key --cert aks-ingress-tls.crt --dry-run=client -o yaml > cert.yaml
kubectl create secret tls aks-ingress-tls --namespace demo-ingress --key aks-ingress-tls.key --cert aks-ingress-tls.crt --dry-run=client -o yaml |Out-File cert.yaml
kubectl apply -f cert.yaml --namespace demo-ingress

#deploy demo sites
kubectl apply -f demo-site-1.yaml --namespace demo-ingress
kubectl apply -f demo-site-2.yaml --namespace demo-ingress

#deploy ingress
kubectl apply -f demo-ingress.yaml

#Listing IP - POTENTIAL REMOVAL
#kubectl get service -l app=nginx-ingress --namespace demo-ingress

# curl -v -k --resolve demo.azure.com:443:40.87.46.190 https://demo.azure.com/demo1
# curl -v -k --resolve demo.azure.com:443:40.87.46.190 https://demo.azure.com/demo2
