#!/bin/bash
#created 1.9.23
#last edited 1.9.23

#Notes: The goal of this bash script are to get counts of sequences in each step. 
#Inputs and outputs are the things that change here and save the file names
#The header is to add a header to the top of each file 
orig=$1
header=$2
outputorig=$3
smps="samples"

for fname in $orig/*.gz; do
 echo "$fname `zcat $fname | wc -l | awk '{print $1 / 4}'`"
done | sed -n 's/^\(.*\/\)*\(.*\)/\2/p' | sed -E 's/[_]...*fastq.gz//g' >interrim 

echo $smps $header | cat - interrim > $outputorig
rm interrim
