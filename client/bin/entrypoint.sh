#!/usr/bin/env sh
# BusyBox


set -ex

sed_escape() {
echo -E "$1" | sed -r 's/([^[:alnum:]])/\\\1/g'
}


cd /usr/local/etc

# ss-client
if [[ ! -z ${ss_server} ]]; then
    sed -ri "s|(\"server\": ).*,|\1${ss_server},|" ss-client.json
fi
if [[ ! -z ${ss_server_port} ]]; then
    sed -ri "s|(\"server_port\": ).*,|\1${ss_server_port},|" ss-client.json
fi
if [[ ! -z ${ss_pwd} ]]; then
    ss_pwd_E=$(sed_escape ${ss_pwd})
    sed -ri "s|(\"password\": \").*\",|\1${ss_pwd_E}\",|" ss-client.json
fi
if [[ ! -z ${ss_method} ]]; then
    sed -ri "s|(\"method\": \").*\",|\1${ss_method}\",|" ss-client.json
fi
if [[ ! -z ${ss_timeout} ]]; then
    sed -ri "s|(\"timeout\": ).*,|\1${ss_timeout},|" ss-client.json
fi


# gqclient
if [[ ! -z ${gq_key} ]]; then
    gq_key_E=$(sed_escape ${gq_key})
    sed -ri "s|(\"Key\": \").*\",|\1${gq_key_E}\",|" gqclient.json
fi


/usr/bin/ss-local -c ss-client.json &

if [[ "$#" != 0 ]]; then
    eval "$@"
fi

wait
