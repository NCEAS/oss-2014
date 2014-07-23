#!/bin/bash

# Example of a simple shell script
# Do not really use this for backup!
PREFIX="backup-"
FILES=$@
for file in $FILES
do
    cp $file $PREFIX$file
done
