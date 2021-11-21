#! /usr/env/python
"""
A simple python script to list the users home directory
using `python-irodsclient`, via an `iquest` style query.
"""

import os
import ssl
from irods.session import iRODSSession
from irods.models import Collection, DataObject

# import the Users iRODS environment, first checking to see if 
#  the `$IRODS_ENVIRONMENT_FILE` (which can be used to point to another
#  irods_environment.json file) environment variable has been set,
#  in which case use that first.

try:
    env_file = os.environ['IRODS_ENVIRONMENT_FILE']
except KeyError:
    env_file = os.path.expanduser('~/.irods/irods_environment.json')

# iRODS can use SSL so this code ensures the python client uses
# the same configuration - as it can be configured to reject non SSL connections!

ssl_context = ssl.create_default_context(purpose=ssl.Purpose.SERVER_AUTH, cafile=None, capath=None, cadata=None)
ssl_settings = {'ssl_context': ssl_context}

# now establish the session with the iRODS server
with iRODSSession(irods_env_file=env_file, **ssl_settings) as session:
    pass

    # set timeout to 10 mins rather than 2.
    session.connection_timeout = 600 

    query = session.query(Collection.name, 
                          DataObject.id, 
                          DataObject.name, 
                          DataObject.size)

    for result in query:
        print('{}/{} id={} size={}'.format(result[Collection.name], 
                                            result[DataObject.name], 
                                            result[DataObject.id], 
                                            result[DataObject.size]
                                            )
            )

