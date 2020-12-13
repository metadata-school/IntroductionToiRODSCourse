# Scripting iRODS with Python

## Setting up

Create a Virtualenv
```
# if not installed, ask your admin to run `sudo apt install virtualenv`
virtualenv /tmp/prc
source /tmp/prc/bin/activate
pip install python-irodsclient==0.8.5
```
N.B When trying out this workbook, make sure you have the virtualenv sourced.

## Basic 'ils' Replacement

Take a look through [ListHomeDir.py](../Examples/ListHomeDir.py) and run it. Is it output similar to the output of an `ils` of your homedir? 

### Follow On Excercises

1. Can you add "create time" and "replica status" to the output report? (Hint: load the code into REPL and run dir(obj) or read the source (see Credits)).
2. Can you extend the code to print any/all metadata attached to an object?

## Basic iQuest Replacement



# Credits

Examples thanks to example code at [Python iRODs Client](https://github.com/irods/python-irodsclient).