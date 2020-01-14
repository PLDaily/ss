#!/usr/bin/env sh
# BusyBox


set -ex

sed_escape() {
echo -E "$1" | sed -r 's/([^[:alnum:]])/\\\1/g'
}


cd /usr/local/etc

# ss-server
if [[ ! -z ${ss_server_port} ]]; then
    sed -ri "s|(\"server_port\": ).*,|\1${ss_server_port},|" ss-server.json
fi
if [[ ! -z ${ss_pwd} ]]; then
    ss_pwd_E=$(sed_escape ${ss_pwd})
    sed -ri "s|(\"password\": \").*\",|\1${ss_pwd_E}\",|" ss-server.json
fi
if [[ ! -z ${ss_method} ]]; then
    sed -ri "s|(\"method\": \").*\",|\1${ss_method}\",|" ss-server.json
fi
if [[ ! -z ${ss_timeout} ]]; then
    sed -ri "s|(\"timeout\": ).*,|\1${ss_timeout},|" ss-server.json
fi
if [[ ! -z ${ipv6} ]]; then
    sed -ri "s|(\"ipv6_first\": ).*,|\1${ipv6},|" ss-server.json
fi


# gqserver
if [[ ! -z ${gq_wsaddr} ]]; then
    sed -ri "s|(\"WebServerAddr\": \").*\",|\1${gq_wsaddr}\",|" gqserver.json
fi
if [[ ! -z ${gq_key} ]]; then
    gq_key_E=$(sed_escape ${gq_key})
    sed -ri "s|(\"Key\": \").*\",|\1${gq_key_E}\",|" gqserver.json
fi


/usr/bin/ss-server -c ss-server.json &

if [[ "$#" != 0 ]]; then
    eval "$@"
fi

wait
