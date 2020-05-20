#!/bin/bash
#Generate new cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out aks-ingress-tls05212020.crt -keyout aks-ingress-tls05212020.key -subj "/CN=demo.azure.com/O=aks-ingress-tls"

#Remove sym link
rm aks-ingress-tls.key aks-ingress-tls.crt

#Symbolic links
ln -s /akscert/aks-ingress-tls05212020.crt /akscert/aks-ingress-tls.crt
ln -s /akscert/aks-ingress-tls05212020.key /akscert/aks-ingress-tls.key

#kubectl secret generation
kubectl create secret tls aks-ingress-tls --namespace demo-ingress --key aks-ingress-tls.key --cert aks-ingress-tls.crt --dry-run=client -o yaml>cert.yaml

#Apply cert.yaml
kubectl apply -f cert.yaml --namespace demo-ingress