#!/bin/bash

readonly FILE_ARRAY=(".bash_profile", ".bashrc")
readonly BACKUP_DIRECTORY="./backup"

check_existing_dot_files()
{
  echo "Checking for existing dot files."
  for fileName in ${FILE_ARRAY[*]}; do
    echo "Checking for" $fileName
    if [ -f $fileName ]
    then
      echo "$fileName found."
      create_backup_for_file $fileName
    else
      echo $fileName "not found."
    fi
  done
}

create_backup_for_file()
{
  fileName=$1
  echo "Creating a backup for file" $fileName
  # Check if the backup directory exists.
  if [ ! -d $BACKUP_DIRECTORY ]
  then
    echo "Backup directory not found. Creating directory at" $BACKUP_DIRECTORY
    #TODO: Create the backup directory
  else
    echo "Backup directory found!"
  fi

  #TODO: create the backup of the file and append a timestamp to the filename
}

###
# Main body of setup script starts here
###
echo "Starting setup!"
check_existing_dot_files
