#! /bin/bash 
set -euo pipefail
# script to deploy the files for a treasure hunt at the end of the course
# Player has to find another file with matching metadata and download it 
# to find the location of a different file that contains a secret word 
# created for this 'treasure hunt'.
#
# IMPORTANT README!
# users.txt is a file containing all the iRODS accounts to take part 
# in the game.  Each account must be on a separate line.
#
# Set the base collection path for the test directory with:
# COLL="/collection/path" SetupTreasureHunt.sh
# this must be a collection all the accounts have at least read access to.
# AND the account running the script must have write access to.

COLL=${COLL:-"/tempZone/iRODSCourse"}
PLAYERS="users.txt"

#check the user priv
if [ "$(iuserinfo | grep type | cut -d: -f2 | xargs)" != 'rodsadmin' ];
then
    echo -e "\e[31mscript must be run by a rodsadmin account\e[0m"
    exit 1
fi

#create another file in another directory with a randomly generated word & assign different metadata to it.
# print word to console so admin can pass onto trainer if required
TMPFILE=$(mktemp /tmp/.irodscourse.XXXXXXXXXX) || exit 1
openssl rand -base64 -out "$TMPFILE" 8
secret=$(cat "${TMPFILE}")
echo -e "\e[32mPlease tell the instructor the secret is: ${secret}\e[0m"

TMPFILE=$(mktemp /tmp/.irodscourse_clue.XXXXXXXXXX) || exit 1
openssl rand -base64 -out "$TMPFILE" 8
clue=$(cat "${TMPFILE}")
echo -e "\e[32mPlease tell the instructor the clue is: ${clue}\e[0m"


GAMEFILELOC=$(mktemp /tmp/irodscourse_.XXXXXXXXXX.txt) || exit 1
/bin/cat <<EOM >"$GAMEFILELOC"
Welcome to the iRODS Treasure Hunt!

You need to use the knowledge of the icommands to navigate 
your way around the iRODS file system and metadata.

Your first hint - what files share the metadata of this file?
EOM
echo -e "\e[32mcreated users instruction file at: ${GAMEFILELOC}\e[0m" 
GAMEFILE="${GAMEFILELOC##*/}"

ANSWERFILELOC=$(mktemp /tmp/.irodscourse_answer.XXXXXXXXXX.txt) || exit 1
/bin/cat <<EOM >"$ANSWERFILELOC"
Congratulations! You have found the secret treasure!
Tell the instructor in private chat the secret word is ${secret}
EOM
echo -e "\e[32manswer file at: ${ANSWERFILELOC}\e[0m" 
ANSWERFILE="${ANSWERFILELOC##*/}"

# upload a file to $COL with the secret in it and set the metadata 
#echo -e "\e[32mUploading answer file to ${COLL}/${ANSWERFILE}\e[0m"
#iput -K --metadata="clue;${clue}" "${ANSWERFILELOC}" "${COLL}/${ANSWERFILE}"

# upload a file to $COL with the instructions in it and set the metadata 
echo -e "\e[32mPlease Tell Instructor users game file will be at ${COLL}/${GAMEFILE}\e[0m"
iput -K --metadata="clue;${clue}" "${GAMEFILELOC}" "${COLL}/${GAMEFILE}"

echo -e "\e[32mUploading ${ANSWERFILELOC}\e[0m"
iput -K --metadata="clue;${clue}" "${ANSWERFILELOC}" "${ANSWERFILE}"

#get zone name in case of federated users
zone=$(iuserinfo | grep zone | cut -d: -f2 | xargs)
iuser=$(iuserinfo | grep name | cut -d: -f2 | xargs)
answer="/${zone}/home/${iuser}/${ANSWERFILE}"
game="${COLL}/${GAMEFILE}"

#check for existence of users file, abort if not present and readable
if test -r "$PLAYERS" -a -f "$PLAYERS"
then 
    while read -r LINE; do
        #echo "Processing User: ${LINE}"
        echo -e "\e[32mGranting read permission to ${LINE} to ${answer}\e[0m"
        ichmod -M read "${LINE}" "${answer}"
        echo -e "\e[32mGranting read permission to ${LINE} to ${game}\e[0m"
        ichmod -M read "${LINE}" "${game}"
    done < $PLAYERS
else
    echo -e "\e[31mcan't read $PLAYERS\e[0m"
    exit 1
fi 
