# icommands - Command Line Access to iRODS

This workbook assumes you have access to an iRODS system already setup.
If that's not the case, but you can run docker containers, take a look at the [Self Service](../SelfService/README.md) notes, which has a way to spin up an iRODS infrastructure you can use.

## Getting Started

1. Logon to your test system
2. Show the current environment with `ienv`
3. Find out about your account with `iuserinfo`

Can you see how the two separate sets of output relate?


### Answer These Questions in Chat:

1. What is your iRODS Home Directory?
2. What iRODS Zone are you in?
3. Did you have to provide a password for either of the above commands?


### Follow On Exercises

1. if you had to provide a password for either command, use the `iinit` command, provide the password again, and you shouldn't need to do so again. We'll explain more about that shortly!
2. Look at the .irods directory in your homedir. _Don't modify any files_, or things may stop working (so use commands like `more` and `view` instead of `pico` or `vi`). How do the files there relate to the information you have seen?


## Listing objects with `ils`

1. show the files in your home 'collection' with `ils`
2. get more detail with `ils -L`
3. View the Access Control Lists with `ils -A`

### Follow On Exercises

1. what's the difference between the `ils -A` output for an object vs a collection?

## Uploading Files with `iget` 

```
#create a small file
dd if=/dev/zero of=/tmp/"{$USER}_iget_small" bs=1k count=42
#upload the file to your home collection
iput -K --progress -V /tmp/"${USER}_iget_small"
```

### Follow On Exercises

1. Try it again. What happens?
2. Try it again with -f. What’s different? 
3. Try it with iput -K --progress -V <file> <newfilename>. What happens?
4. Try (3) with a new filename and without -K then look at both files with `ils -L`. What’s different?
5. Create a file larger than 64MB and upload it using the same settings. What's changed?

## Retrieving Files with `iget`

`iget -K --progress -V <file>`

### Follow On Exercises
1. Try it again. What happens?
2. Try it _again_ with the additional argument of `-f`. What’s different?
3. Try it with the small and large files. How does it differ?

## Removing Files

`irm <a file you have previously uploaded>`

(If you haven’t uploaded file, upload one now with iput)

### Follow on Exercises: 

1. Verify its gone with ils
2. List (ils) the trash e.g. /myZone/trash/home/myUserName
3. Try deleting the trash file with irmtrash. 
4. List both home directory and trash home directory. 

## Collections

```
imkdir testdir
icd testdir
```

### Follow on Exercises: 
1. Try ils after each step
2. Get back to your homedir with icd 
3. Try to create the collection again. What happens?

## ichmod

Pick a colleague, ask them what their username in iRODS is.

Give them access to a file in your homedir with 

`ichmod read <user> <file>`

(If you haven’t uploaded file, upload one now with iput)

N.B. Remember that they will need to use `/zonename/home/youruser/<file>` to access the file.


### Follow on Exercises: 
1. Can they view the file with ils?
2. What do you see when you do `ils -A` on the file? 
2. Can they overwrite the file with iput? Why not? What would you need to let them do this? 

## Copying and Moving Objects

Pick a colleague, ask for access to a file in their homedir.

Copy it to your homedir with

`icp /myZone/home/ThierUserName/<file> /myZone/home/YourUserName`

### Follow on Exercises: 

1. Do both files still exist (`ils`) 
2. Can you `imv` the file? Why/why not? What permission would they need to grant? 
