#!/bin/bash

dir_exists(){
    if ! [[ -d $1 ]]; then
        echo -e "$1 doesn't exist \nCreating..."
        mkdir -p "$1" 
        if [[ $? -eq 0 ]]; then
            echo "Directory $1 has been created successfully"
            compress_in_dir $1 
        else
            echo "Something went wrong while creating new directory $1"
        fi
    else
        echo "$1 already exists"
    fi
}

compress_in_dir(){
    target_dir=$1
    dir_to_compress=$2

    echo $DIR_WITH_COMPRESSED

    tar cvzf "$target_dir/docs-$(date +%Y-%m-%d).tar.gz"  "$dir_to_compress"
    if [[ $? -eq 0 ]]; then
        echo -e "Directory \"$dir_to_compress\" was successfully compressed in the directory \"$target_dir\" "
    else
        echo "Something went wrong while compressing"
    fi
}

delete_older_than_7_days(){
    target_dir=$1
    
    outdated_files=$(find $target_dir -ctime +7 -exec rm {} \;)
    if [[ $? -eq 0 ]] && [[ $outdated_files -ne "" ]]; then
        echo -e "$outdated_files were removed from dir \"$target_dir\" "
    else
        echo "Something went wrong while deleting the outdated files or files not exist"
    fi
}

# Main
DIR_WITH_COMPRESSED="${1:-/backups}"
DIR_TO_COMPRESS="${2:-/etc}"

if ! dir_exists "$DIR_WITH_COMPRESSED" || ! dir_exists "$DIR_TO_COMPRESS"; then
    echo "Exiting with status 1: one or $DIR_WITH_COMPRESSED or $DIR_TO_COMPRESS does not exist!"
    exit 1
fi

compress_in_dir $DIR_WITH_COMPRESSED $DIR_TO_COMPRESS
if [[ $? -eq 0 ]]; then 
    delete_older_than_7_days $DIR_WITH_COMPRESSED
else
    exit 1
fi
