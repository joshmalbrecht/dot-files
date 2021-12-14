#!/bin/bash
readonly FILE_ARRAY=(".bash_profile" ".bashrc")
readonly BACKUP_DIRECTORY_NAME="backup"

#Colors used for displaying text in different colors.
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function red() {
    echo "$RED$*$NORMAL"
}

function green() {
    echo "$GREEN$*$NORMAL"
}

function yellow() {
    echo "$YELLOW$*$NORMAL"
}

check_existing_dot_files()
{
  echo "Checking for existing dot files. If existing file exists, an attempt will be made to archive the file."
  for fileName in ${FILE_ARRAY[*]}; do
    if [ -a "$HOME/$file" ]
    then
      create_backup $fileName
      create_symbolic_link $fileName
    fi
  done
}

create_backup()
{
  fileName=$1
  # Check if the backup directory exists.
  if [ ! -d $BACKUP_DIRECTORY_PATH ]
  then
    mkdir -p -- "$BACKUP_DIRECTORY_NAME"
  fi

  #Copy the file to the backup folder.
  cp -r "$HOME/$fileName" $BACKUP_DIRECTORY_PATH

  #Rename the archived file with current epoch.
  currentEpoch=`date "+%s"`
  fileNewName="$fileName-"$currentEpoch
  mv "$BACKUP_DIRECTORY_PATH/$fileName" "$BACKUP_DIRECTORY_PATH/$fileNewName"
  green "$fileName has been archived as $fileNewName"

  #Remove the file in HOME
  rm "$HOME/$fileName"
}

create_symbolic_link()
{
  fileName=$1
  ln -s "$CURRENT_WORKING_DIRECTORY/$fileName" $HOME
}

###
# Main body of setup script starts here
###
echo "Starting setup!"
CURRENT_WORKING_DIRECTORY="$(pwd)"
BACKUP_DIRECTORY_PATH="$CURRENT_WORKING_DIRECTORY/$BACKUP_DIRECTORY_NAME"
check_existing_dot_files
green "Setup completed!"
