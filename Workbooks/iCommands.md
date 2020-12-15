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
dd if=/dev/zero of=/tmp/$USER_iget_small bs=1k count=42
#upload the file to your home collection
iput -K --progress -V /tmp/$USER_iget_small
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
