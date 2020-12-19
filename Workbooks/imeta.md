# imeta - Metadata Access and Manupulation in iRODS

This workbook assumes you have access to an iRODS system already setup.
If that's not the case, but you can run docker containers, take a look at the [Self Service](../SelfService/README.md) notes, which has a way to spin up an iRODS infrastructure you can use.

## Listing Metadata

Pick a file you have already uploaded (check with `ils` or upload a new one with `iput`), and add an AVU of your choice, e.g.

`imeta add -d /myZone/home/UserName/<file> BasketItem Banana Fruit `


## Follow on Exercises: 

1. View metadata (imeta ls) 
2. Can you add a similar metadata without the unit? What happens? Why might you not want to do this?
3. What differences does imeta ls -ld give you? 

## Removing Metadata

Pick a file you have already applied metadata to and remove an AVU of your choice, e.g.

`imeta rm-d /myZone/home/UserName/<file> BasketItem`

## Follow on Exercises: 

1. View metadata (`imeta ls -ld <file>`) 

## Searching Metadata

Let’s see how can we apply metadata to the files to find them later.

#### Download Test Files

Upload some books from Project Gutenburg; e.g.
1. [Shaving Made Easy: What the Man Who Shaves Ought to Know by Anonymous](https://www.gutenberg.org/ebooks/43166)
2. [Shavings: A Novel by Joseph Crosby Lincoln](https://www.gutenberg.org/ebooks/2452)

TODO - use curl to download to name instead
```
wget https://www.gutenberg.org/ebooks/43166.epub.images?session_id=7992ad5e5679ccd1ca8c463883a8215f50a81efa
wget https://www.gutenberg.org/ebooks/2452.epub.noimages?session_id=7992ad5e5679ccd1ca8c463883a8215f50a81efa
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


From the local copy of the GitHub for the course you made earlier 
(git clone https://github.com/metadata-school/IntroductionToiRODSCourse.git )
Follow the "Removing Metadata"  section.