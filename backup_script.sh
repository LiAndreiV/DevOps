#!/bin/bash

DIRECTORY=$1
COMPRESSION=$2
OUTPUTFILE=$3

exec >logfile.txt 2>&1

case $COMPRESSION in
 none )
    tar -cf "${OUTPUTFILE}.tar" -C $DIRECTORY .
	EXT="tar"
    ;;
 gzip )
    tar -czf "${OUTPUTFILE}.tar.gz" -C $DIRECTORY .
	EXT="tar.gz"
    ;;
 bzip )
    tar -cjf "${OUTPUTFILE}.tar.bz2" -C $DIRECTORY .
	EXT="tar.bz2"
    ;;
 xz )
    tar -cJf "${OUTPUTFILE}.tar.xz" -C $DIRECTORY .
	EXT="tar.xz"
    ;;
 * )
    echo "Wrong compression format. Select from list [none, gzip, bzip, xz]"
    ;;
esac

if [[ -v EXT ]]
then
	openssl enc -aes-256-cbc -salt -in "${OUTPUTFILE}.${EXT}" -out "${OUTPUTFILE}.enc"
	rm $OUTPUTFILE
fi
