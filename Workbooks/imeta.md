# imeta - Metadata Access and Manipulation in iRODS

This workbook assumes you have access to an iRODS system already setup.
If that's not the case, but you can run docker containers, take a look at the [Self Service](../SelfService/README.md) notes, which has a way to spin up an iRODS infrastructure you can use.

## Listing Metadata

Pick a file you have already uploaded (check with `ils` or upload a new one with `iput`), and add an AVU of your choice, e.g.

`imeta add -d /myZone/home/UserName/<file> BasketItem Banana Fruit `


### Follow on Exercises: 

1. View metadata (imeta ls) 
2. Can you add a similar metadata without the unit? What happens? Why might you not want to do this?
3. What differences does imeta ls -ld give you? 

## Removing Metadata

Pick a file you have already applied metadata to and remove an AVU of your choice, e.g.

`imeta rm-d /myZone/home/UserName/<file> BasketItem`

### Follow on Exercises: 

1. View metadata (`imeta ls -ld <file>`) 

## Searching Metadata

Let’s see how can we apply metadata to the files to find them later.

#### Download Test Files

Upload some books from Project Gutenburg; e.g.
1. [Shaving Made Easy: What the Man Who Shaves Ought to Know by Anonymous](https://www.gutenberg.org/ebooks/43166)
2. [Shavings: A Novel by Joseph Crosby Lincoln](https://www.gutenberg.org/ebooks/2452)

```
curl -o ShavingMadeEasy.mobi https://www.gutenberg.org/ebooks/43166.epub.images?session_id=
7992ad5e5679ccd1ca8c463883a8215f50a81efa
curl -o Shavings.mobi https://www.gutenberg.org/ebooks/2452.epub.noimages?session_id=7992ad5e5679ccd1ca8c463883a8215f50a81efa
```

#### Upload The Files

```
iput ShavingMadeEasy.mobi
iput Shavings.mobi
```

#### Add Metadata

Now we have the files, let’s add some metadata about them

```
imeta add -d ShavingMadeEasy.mobi Author Anonymous
imeta add -d Shavings.mobi Author "Joseph Crosby Lincoln"
```

#### View the metadata

```
imeta ls -ld ShavingMadeEasy.mobi
```

### Follow on Exercises: 

1. Add the relevant 'Title' metadata to both objects.
2. What other metadata could you add?


#### Searching Metadata with Wildcards

Let’s find all the files that have a metadata field of ‘Author’ set, and which starts with ‘A’

`imeta qu -d Author like A%`

#### Searching Metadata within a String

How about searching within the string, in this case for part of an Author’s name

`imeta qu -d Author like %Crosby%`


#### Searching where Metadata Name Exists

Finally, find all the files where the Author metadata has been set

`imeta qu -d Author like %`

### Follow on Exercises: 

1. Pick another eBook and upload it with the same metadata fields, but this time, apply the metadata at time of upload using `iput` [Docs Link](https://docs.irods.org/4.2.8/icommands/user/#iput)
2. Check the same searches you just used find the new object.


## iquest 

Generate a report of the size of the data stored by all users, by user;

`iquest "User %-9.9s uses %14.14s bytes in %8.8s files in '%s'" "SELECT USER_NAME, sum(DATA_SIZE),count(DATA_NAME),RESC_NAME"`


### Follow on Exercises: 

1. Upload some more files and rerun to see the numbers change.

## iquest Predefined Queries

List the existing queries on the Zone with

`iquest --sql ls`

## iquest Usage Check

Using the help (-h /  [Docs Link](https://docs.irods.org/4.2.8/icommands/user/#iquest) ) output of iquest, formulate and run a query that shows how much disk space is used in your home directory.

### Follow on Exercises: 

1. Use the printf format to display the output on one line
2. Use the printf and help to write a query that shows how many files _and_ how much space used in total, all on one line. 



From the local copy of the GitHub for the course you made earlier 
(git clone https://github.com/metadata-school/IntroductionToiRODSCourse.git )
Follow the "Removing Metadata"  section.