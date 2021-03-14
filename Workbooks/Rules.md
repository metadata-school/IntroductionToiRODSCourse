# iRODS Rules

This workbook will take you through an example of using the iRODS Legacy Rule Language.
The files referred to are in the Examples directory at the top of this repo.

## Hello World!

A traditional start!

Run the [ruleprint_hello.r](../Examples/ruleprint_hello.r) rule with

`irule --file ../Examples/ruleprint_hello.r`

### Follow On Exercises

Number two is extra optional and suggested only for those who have raced through the rest and/or a programming background, at least in the time we have today!

1. Try with `irule --list --file ../Examples/ruleprint_hello.r` what's the difference? Why?
2. Try again with the verbose option set. What's the difference? 
3. upload the 'hello' rule file into iRODS and run it using `irule` and the `i:rulefile_name` instead of the local copy of the rule.
4. from the `irule -h` help or the [online documentation for iRule and the Rule Language](https://docs.irods.org/4.2.8/icommands/user/#irule) can you make the 'Source' and 'Destination' variables as input arguments to the rule?


# Credits
All the rules here were originally from [irods_client_icommands](https://github.com/irods/irods_client_icommands/blob/master/test/rules/) repository.

