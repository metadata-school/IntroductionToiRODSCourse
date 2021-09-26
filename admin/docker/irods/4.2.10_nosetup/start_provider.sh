#! /bin/bash

# Start the Postgres database.
service postgresql start
counter=0
until pg_isready -q
do
    sleep 1
    ((counter += 1))
done
echo Postgres took approximately $counter seconds to fully start ...

# Set provider to refuse SSL connections, i.e. CS_NEG_REFUSE
sed -i 's/CS_NEG_DONT_CARE/CS_NEG_REFUSE/' /var/lib/irods/packaging/core.re.template

# Set up iRODS.
if [ ! -e /var/lib/irods/VERSION.json ]; then
python /var/lib/irods/scripts/setup_irods.py < /var/lib/irods/packaging/localhost_setup_postgres.input

cd /var/lib/irods/scripts
python configure_users.py
pkill irodsServer
fi

# set the permissions for the github
chown -R irods:irods /training

#create the test users
# iRODS environment files are created by adduser.local script
sudo adduser --home /home/ash --shell /bin/bash --ingroup irods --gecos '' --disabled-login ash
sudo adduser --home /home/berri --shell /bin/bash --ingroup irods --gecos '' --disabled-login berri


#give it a bit for the procs to finish
running="True"

while [ $running = "True" ]
do
response=$(echo -e "\x00\x00\x00\x33<MsgHeader_PI><type>HEARTBEAT</type></MsgHeader_PI>" | nc localhost 1247)
if [ "${response}" == "HEARTBEAT" ]; then
    running="True"
    echo "iRODS responding to Heartbeat"
else
    running="False"
    echo "Restarting iRODS"
    sudo -iu irods bash -c "cd /usr/sbin; ./irodsServer -u"
fi
sleep 1
done
