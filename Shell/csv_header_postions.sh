#!usr/bin/bash

FILENAME=$1;
DELIM=$2;

echo "delimiter identifed: "$DELIM;

head -n1 $FILENAME | awk -v sep=$DELIM 'BEGIN { FS=sep }
{
	for (fn=1; fn<=NF; fn++) {
		print fn - 1" = "$fn;
	};
	exit;
}'