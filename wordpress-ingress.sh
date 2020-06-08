#Creating namespace
kubectl create namespace wordpress

#install public ingress controller
helm install nginx-ingress-wp stable/nginx-ingress --namespace wordpress --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

#install internal ingress controller
helm install nginx-ingress-wp-int stable/nginx-ingress --namespace wordpress -f internal-ingress.yaml --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

#Createing SSL Cert in current directory
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out aks-ingress-tls.crt -keyout aks-ingress-tls.key -subj "/CN=demo.azure.com/O=aks-ingress-tls"

#Adding certs as cluster secret
kubectl create secret tls aks-ingress-tls --namespace wordpress --key aks-ingress-tls.key --cert aks-ingress-tls.crt --dry-run=client -o yaml > cert.yaml
kubectl apply -f cert.yaml --namespace wordpress

#Fetch from VAULT to put into ENV varables
sh ./fetch-from-vault.sh <YOUR-VAULT-NAME>

#substitute variables, deploy wordpress
cat wordpress-deployment.yaml | envsubst | kubectl apply -f - --namespace wordpress

#deploy ingress
kubectl apply -f wordpress-ingress.yaml --namespace wordpress

# curl -v -k --resolve demo.azure.com:443:40.87.46.190 https://demo.azure.com
