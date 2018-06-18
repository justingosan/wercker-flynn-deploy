#!/bin/sh

if [ ! -n "$FLYNN_CLUSTER_NAME" ]; then
    error 'Please specify Cluster Name'
    exit 1
fi

if [ ! -n "$FLYNN_CONTROLLER_DOMAIN" ]; then
    error 'Please specify Controller Domain'
    exit 1
fi

if [ ! -n "$FLYNN_CONTROLLER_KEY" ]; then
    error 'Please specify Controller Key'
    exit 1
fi

if [ ! -n "$FLYNN_APP_NAME" ]; then
    error 'Please specify App Name'
    exit 1
fi

if [ ! -n "$FLYNN_TLS_CERT" ]; then
    error 'Please specify Tls Cert'
    exit 1
fi

if [ ! -n "$FLYNN_CERT_PEM" ]; then
    error 'Please specify FLYNN_CERT_PEM'
    exit 1
fi

rm -rf .git
git init
git config user.email "oracle-wercker@wercker.com"
git config user.name "oracle-wercker"
git checkout master
git add --all .
git commit -am "deploy from $WERCKER_STARTED_BY"
git show-ref

L=/usr/local/bin/flynn && curl -sSL -A "`uname -sp`" https://dl.flynn.io/cli | zcat >$L && chmod +x $L
flynn cluster add -p $FLYNN_TLS_CERT $FLYNN_CLUSTER_NAME $FLYNN_CONTROLLER_DOMAIN $FLYNN_CONTROLLER_KEY
flynn -a $FLYNN_APP_NAME remote add
echo "$FLYNN_CERT_PEM" > /root/.flynn/ca-certs/default.pem
chmod 644 /root/.flynn/ca-certs/default.pem
git push -f flynn master