# iRODS Rules

This workbook will take you through several examples of using the iRODS Legacy Rule Language.
The files referred to are in the Examples directory at the top of this repo.

## Hello World!

A traditional start!

Run the `ruleprint_hello.r` rule with

`irule --file ../Examples/ruleprint_hello.r`

### Follow On Excercises

1. Try with `irule --list --file ../Examples/ruleprint_hello.r` whats the difference? Why?
2. Try again with the verbose option set. Whats the difference? 

## Copy Metadata

First, create and upload a file, attaching metadata to it at the same time, e.g.

```
#create a small file
dd if=/dev/zero of=/tmp/metadata_rule_test bs=1M count=64
#upload it with some metadata
iput -K -V --progress --metadata "Favourite;cake;food" /tmp/metadata_rule_test 
#check the file is there
ils
#check the metadata is present
imeta ls -ld metadata_rule_test
```
Then upload a second file (call it whatever you like), and use a rule to copy the metadata from one file to another.

```
# verify your new file doesn't have the metadata on it.
imeta ls -ld <new_file_name>
# make a copy of the rule
cp ../Examples/rulemsiCopyAVUMetadata.r /tmp/${USER}_rulemsiCopyAVUMetadata.r
#edit the file to change the 'Source' and 'Destination' variables to your old and new files names
# dont forget the collection name needs updating!
vi /tmp/${USER}_rulemsiCopyAVUMetadata.r
irule --file /tmp/${USER}_rulemsiCopyAVUMetadata.r
#check if the metadata has been copied to the new file
imeta ls -ld <new_file_name>
```

Note the way you can add metadata during upload as well, something that wasn't directly addressed in the slides!

### Follow On Excercises

Number two is extra optional and suggested only for those who have raced through the rest and/or a programming background, at least in the time we have today!

1. upload the metadata rule file into iRODS and run it using `irule` and the `i:rulefile_name` instead of the local copy of the rule.
2. from the `irule -h` help or the [online documentation for iRule and the Rule Language](https://docs.irods.org/4.2.8/icommands/user/#irule) can you make the 'Source' and 'Destination' variables as input arguments to the rule?


# Credits
All the rules here were originaly from [irods_client_icommands](https://github.com/irods/irods_client_icommands/blob/master/test/rules/) repository.

