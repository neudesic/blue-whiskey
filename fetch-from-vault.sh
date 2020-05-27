#!/bin/sh
#
# Fetch secrets for local development from Azure KeyVault
# and print them to stdout as a bunch of env var exports.
# These secrets should be added to your local .env file
# to enable running integration tests locally.
#
KEY_VAULT=${1:-fluent-terrier-bw}

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

    echo "export ${SECRET_VAR}=${SECRET_VALUE}"
}

echo "# ----------------------- "
echo "# Fetched the following secrets from ${KEY_VAULT} on "`date`

store_secret_from_keyvault "LNFQDN_PG" "bw-server-fqdn"
store_secret_from_keyvault "LNPORT_PG" "bw-server-port"
store_secret_from_keyvault "LNLOGIN_PG" "bw-server-admin-login"
store_secret_from_keyvault "LNPASS_PG" "bw-server-admin-password"

store_secret_from_keyvault "LNFQDN_PG_MYSQL" "bw-server-fqdn-mysql"
store_secret_from_keyvault "LNPORT_PG_MYSQL" "bw-server-port-mysql"
store_secret_from_keyvault "LNLOGIN_PG_MYSQL" "bw-server-admin-login-mysql"
store_secret_from_keyvault "LNPASS_PG_MYSQL" "bw-server-admin-password-mysql"

echo "# End of fetched secrets. "
echo "# ----------------------- "