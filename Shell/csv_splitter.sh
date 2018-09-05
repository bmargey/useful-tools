#!/usr/bin/bash

FNIN=$1        
ROWS=$2
FNOUT=$3

# given a csv file, this script will split that into defined number of 
# rows and output numbered files. Each file contains the same header row.
   
tail -n +2 $FNIN | split -l $ROWS - parts  

i=1
for p in parts*              
do
  echo $(head -n1 $FNIN) > ${i}_$FNOUT
  cat $p >> ${i}_$FNOUT   
  rm $p                   
  ((i++))                 
done