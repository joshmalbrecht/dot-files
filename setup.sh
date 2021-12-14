#!/bin/bash

readonly FILE_ARRAY=(".bash_profile" ".bashrc")
readonly BACKUP_DIRECTORY_NAME="backup"

check_existing_dot_files()
{
  echo "Checking for existing dot files."
  for fileName in ${FILE_ARRAY[*]}; do
    if [ -a "$HOME/$file" ]
    then
      create_backup_for_file $fileName
    fi
  done
}

create_backup_for_file()
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

  echo "$fileName has been archived as $fileNewName"
}

###
# Main body of setup script starts here
###
echo "Starting setup!"
CURRENT_WORKING_DIRECTORY="$(pwd)"
BACKUP_DIRECTORY_PATH="$CURRENT_WORKING_DIRECTORY/$BACKUP_DIRECTORY_NAME"
check_existing_dot_files
