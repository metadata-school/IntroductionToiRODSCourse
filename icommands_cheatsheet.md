# icommands cheatsheet

A run down of the assorted commands, grouped by use case.

# Nonclemature

* Files in iRODS are called Objects.
* Directories are called Collections.
* A file can have multiple copies. 
* Each copy is called a Replica.


# Authentication

`iinit` - provide a password or extend the token's expiry date (if PAM auth). Once successful will create a `~/.irods/.irodsA` hashed token.

`kinit` - setup a Kerberos token when this is enabled for your account.

`klist` - show current Kerberos tokens & expiry times.

`ienv` - display current iRODS environment (defaults to the content of 
`~/.irods/irods_environment.json` but can be over-ridden with `$IRODS_ENVIRONMENT`)

`ipasswd` - change your iRODS password. Native only.

`iexit` - clear your current authentication (`~/.irods/.irodsA`)

`iuserinfo` - show user information such as group membership. Defaults to current user.

# Navigation

`ils` - list the collections in irods. Defaukts to current working directory.

`ipwd` - prints current working directory.

# File manipulation

`iget` - retrieve an object from iRODS

`iput` - upload an file/directory into iRODS

`irm` - delete objects.

`irmdir` - deletes collections

`irmtrash` - deletes objects from `/zone/trash/...` if Trashcan enabled.

`imkdir` - create collections

`icp` - copy files between collections/zones

`irsync` - like `rsync` synchronises a filesystem directory and collection, or vice versa.

`imv` - move files between collections/Zones

`irepl` - make a replica of an object onto another resource. Collection path stays the same.


# Permissions

`ichmod` - modify object/collection Access Control Lists

# Administrative commands

`imiscsrvinfo` - basic connectivity test to an iRODS server.

`ips` - show current processes on an iRODS server/Zone.

`ilsresc` - show resources available in a Zone.

`iadmin` - for `rodsadmin` accounts only, modifies Zone settings, add users etc.


# Metadata & Searching

`imeta` swiss army knife of metadata addition, removal, modification and searching.

`iquest` - SQL like search syntax for objects, collections, metadata and some system information.


# Rules

`irule` - run iRODS Rule Engine Rules.
