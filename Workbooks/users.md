# Users and Groups

This workbook assumes you have access to an iRODS system already set up.
If that's not the case, but you can run docker containers, take a look at the [Self Service](../SelfService/README.md) notes, which has a way to spin up an iRODS infrastructure you can use. 


## Finding out the user information 

We will cover the `iquest` command in a later section, but for now, try listing users on the system with

`iquest "SELECT USER_NAME"`

Another way to see what users are on the Zone is to look at the home directories, e.g. `ils /tempZone/home`. However, this is less reliable as ACL permissions may have been set to prevent browsing these collections.

### Follow On Exercises

1. Find out more about each user with `iuserinfo <username>`
2. look at the home directories with `ils /tempZone/home` - do the users match the report you made with `iquest`?

## Finding out Group Information

N.B. 

You can list groups with 

`igroupadmin lg`

However, this command will only work for `groupadmin` or `rodsadmin` users.

Instead, we can use the `iquest` command as above, with a small modification;

`iquest "SELECT USER_GROUP_NAME"`

### Follow On Exercises

1. Look at your account with `iuserinfo`. What type is it? Does this mean you will be able to run `groupadmin`?
2. if your account is able to run `igroupadmin lg` do so and see what the differences are. Can you guess why this might be the case?