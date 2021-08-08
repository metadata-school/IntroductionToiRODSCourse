
import os
import sys
import json

from irods.configuration import IrodsConfig
from irods import lib
from irods.test import session

rods = session.make_session_for_existing_admin()

rods.assert_icommand('iadmin mkuser ash rodsuser')
rods.assert_icommand('iadmin moduser training password topsecret')
rods.assert_icommand('iadmin mkuser ash rodsuser')
rods.assert_icommand('iadmin moduser berri password ultratopsecret')
