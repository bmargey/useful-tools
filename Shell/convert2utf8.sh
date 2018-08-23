#!/usr/bin/bash

FILEIN=$1;
FILEOUT=$2;

# convert a file of unknown type to utf-8
# accepts 2 ordered args of file to be converted and output file
# e.g bash convert2utf8.sh ./unknown.txt ./output_utf8.txt

if [ -f "${FILEIN}" ]; 
then
	for format in $(iconv -l);
	do
		echo "Trying format: $format";
		iconv -f $format -t utf-8 ${FILEIN} > ${FILEOUT}
	done 
else
	echo "${FILEIN} Not a file!";
	exit 1;
fi