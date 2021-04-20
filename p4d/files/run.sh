#!/bin/bash

if [ ! -d "/tmp/check" ]; then

mkdir /tmp/check
echo `date` > /tmp/check/first_`date +%Y%m%d_%H%M%S`

/opt/perforce/sbin/configure-helix-p4d.sh $P4NAME -n -p $P4PORT -r $P4ROOT -u $P4USER -P $P4PASSWD --case $CASE_INSENSITIVE --unicode

cat > ~perforce/.p4config <<EOF
P4USER=$P4USER
P4PORT=$P4PORT
P4PASSWD=$P4PASSWD
EOF

chmod 0600 ~perforce/.p4config
chown perforce:perforce ~perforce/.p4config

p4 login <<EOF
$P4PASSWD
EOF

pushd /opt/perforce/servers/master
rm -Rf db.*
rm -Rf journal
popd


else
  echo `date` > /tmp/check/second_`date +%Y%m%d_%H%M%S`

fi

exec "$@"
