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
# Set the base collection path for the test directory with:
# BCOLL="/collection/path" SetupTreasureHunt.sh

COLL=${$BCOLL:-"/tempZone/iRODSCourse"}
PLAYERS="users.txt"

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


GAMEFILE=$(mktemp /tmp/irodscourse_.XXXXXXXXXX.txt) || exit 1
/bin/cat <<EOM >"$GAMEFILE"
Welcome to the iRODS Treasure Hunt!

You need to use the knowledge of the icommands to navigate 
your way around the iRODS file system and metadata.

Your first hint - what files share the metadata of this file?
EOM
echo -e "\e[32mcreated users file at: ${GAMEFILE}\e[0m" 

ANSWERFILE=$(mktemp /tmp/.irodscourse_answer.XXXXXXXXXX.txt) || exit 1
/bin/cat <<EOM >"$ANSWERFILE"
Congratulations! You have found the secret treasure!
Tell the instructor in private chat the secret word is ${secret}
EOM
echo -e "\e[32mcreated answer file at: ${ANSWERFILE}\e[0m" 

# upload a file to $COL with the secret in it and set the metadata 
echo -e "\e[32mcreated Uploading answer file to /${COLL}/${ANSWERFILE}\e[0m"
echo "iput -K --metadata clue;${clue} /${COLL}/${ANSWERFILE}"
 

#check for existence of users file, abort if not present and readable
if test -r "$PLAYERS" -a -f "$PLAYERS"
then 
    while read -r LINE; do
        #create a treasurehunt.txt file in each users iRODS homedir,  ichmod it to them and assign metadata
#print files to admin can remove later if wished.
        echo "Processing User: ${LINE}"
        #get zone name per user in case of federated users
        zone=$(iuserinfo "${LINE}" | grep zone | cut -d: -f2 | xargs)
        # upload file & set metadata & ACL ownership for user on it
        echo -e "\e[32mUploading /${zone}/home/${GAMEFILE}\e[0m"
        echo "iput -K --acl 'own ${LINE}' --metadata clue;${clue} /${zone}/home/${GAMEFILE}"
        echo -e "\e[32mGranting read permission\e[0m"
        ichmod -M read "${LINE}" "/${COLL}/${ANSWERFILE}"
    done < $PLAYERS
else
    echo -e "\e[31mcan't read $PLAYERS\e[0m"
    exit 1
fi 
