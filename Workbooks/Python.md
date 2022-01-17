# Scripting iRODS with Python

## Setting up

If you hit issues creating the virtualenv in either version of Python, please see the [notes about caveats for use with virtualenv](https://github.com/d-w-moore/python-irodsclient/blob/file_desc/PYTHON_install_caveats.rst).

### Create a Virtualenv - python2
```
# if not installed, ask your admin to run `sudo apt install virtualenv`
TMPFILE=$(mktemp)
virtualenv "/tmp/prc_${TMPFILE}"
source "/tmp/prc_${TMPFILE}/bin/activate"
pip install --upgrade pip==20.3.4
pip install python-irodsclient==0.8.5
```

### Create a Virtualenv - python3

```
# if not installed, ask your admin to run `sudo apt-get install python3-venv`
TMPFILE=$(mktemp)
python3 -m venv "/tmp/prc_${TMPFILE}"
source "/tmp/prc_${TMPFILE}/bin/activate"
pip install --upgrade pip==20.3.4
pip install python-irodsclient==0.8.5
```


N.B When trying out this workbook, make sure you have the virtualenv sourced.


## Basic 'ils' Replacement

Take a look through [ListHomeDir.py](../Examples/ListHomeDir.py) and run it. Is it output similar to the output of an `ils` of your homedir? 

### Follow On Exercises

1. Can you add "create time" and "replica status" to the output report? (Hint: load the code into REPL and run dir(obj) or read the source (see Credits)).
2. Can you extend the code to print any/all metadata attached to an object?

## Basic iQuest Replacement

Take a look through [BasicQuery.py](../Examples/BasicQuery.py) and run it. Is the output similar to the output of an `ils` of your home dir? 
How is it different from the previous script?

### Follow On Exercises
1. Can you add checksum output to the script?


# Credits

Examples thanks to example code at [Python iRODS Client](https://github.com/irods/python-irodsclient).
