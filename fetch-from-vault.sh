#!/bin/sh
#
# Fetch secrets for local development from Azure KeyVault
# and print them to stdout as a bunch of env var exports.
# These secrets should be added to your local .env file
# to enable running integration tests locally.
#

#appId=$1
#password=$2
#tenant=$3

#az login --service-principal --username=${appId} --password=${password} --tenant=${tenant}

# can run script like: . fetch-from-vault.sh <KEY_VAULT_NAME>

KEY_VAULT=${1}

function fetch_secret_from_keyvault() {
    local SECRET_NAME=$1

    az keyvault secret show --vault-name "${KEY_VAULT}" --name "${SECRET_NAME}" --query "value"
}

function store_secret_from_keyvault() {
    local SECRET_VAR=$1
    local SECRET_NAME=$2

    local SECRET_VALUE=`fetch_secret_from_keyvault "${SECRET_NAME}"`
    store_secret "${SECRET_VAR}" "${SECRET_VALUE}"
}

function store_secret() {
    local SECRET_VAR=$1
    local SECRET_VALUE=$2

    export ${SECRET_VAR}=${SECRET_VALUE}
    echo "export ${SECRET_VAR}=${SECRET_VALUE}"
    #unset ${SECRET_VAR}
}

echo "# ----------------------- "
echo "# Fetched the following secrets from ${KEY_VAULT} on "`date`

store_secret_from_keyvault "LN_FQDN_PG" "bw-server-fqdn"
store_secret_from_keyvault "LN_PORT_PG" "bw-server-port"
store_secret_from_keyvault "LN_LOGIN_PG" "bw-server-admin-login"
store_secret_from_keyvault "LN_PASS_PG" "bw-server-admin-password"

store_secret_from_keyvault "LN_FQDN_MYSQL" "bw-server-fqdn-mysql"
store_secret_from_keyvault "LN_PORT_MYSQL" "bw-server-port-mysql"
store_secret_from_keyvault "LN_LOGIN_MYSQL" "bw-server-admin-login-mysql"
store_secret_from_keyvault "LN_PASS_MYSQL" "bw-server-admin-password-mysql"

echo "# End of fetched secrets. "
echo "# ----------------------- "

# make sure you have access to your k8s cluster, if not: az aks get-credentials -g <RG-GROUP-NAME> -n <K8s-CLUSTER-NAME> 
# to do the ENV variable substitution: cat wordpress-deployment.yaml | envsubst | kubectl apply -f -
# after this spins up the pod, get external IP (kubectl get services) and add to mySQL firewall rule in terraform, run it, then back here to delete pod to have it recreated
# then you can put external IP in browser to get to wordpress site
# if you have issues, look at logs: kubectl logs -f <POD-NAME>