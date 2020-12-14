# icommands - Command Line Access to iRODS

This workbook assumes you have access to an iRODS system already setup.
If thats not the case, but you can run docker containers, take a look at the [Self Service](../SelfService/README.md) notes, which has a way to spin up an iRODS infrastructure you can use.

## Getting Started

1. Logon to your test system
2. Show the current environment with `ienv`
3. Find out about your account with `iuserinfo`

Can you see how the two seperate sets of output relate?


### Answer These Questions in Chat:

1. What is your iRODS Home Directory?
2. What iRODS Zone are you in?
3. Did you have to provide a password for either of the above commands?


### Follow On Excercises

1. if you had to provide a password for either command, use the `iinit` command, provide the password again, and you shouldn't need to do so again. We'll explain more about that shortly!
2. Look at the .irods directory in your homedir. _Don't modify any files_, or things may stop working (so use commands like `more` and `view` instead of `pico` or `vi`). How do the files there relate to the information you have seen?
