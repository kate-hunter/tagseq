#!/bin/bash
#created 1.9.23
#last edited 1.9.23

#this script is getting used to get the trimming read counts as they are not gzipped and 
#have a fastq filename-they are also in a 4line per sequence count

set -e

orig=$1
header=$2
outputorig=$3

echo "samples $header"

for fname in $orig/*.fastq; do
 echo "$fname `wc -l $fname | awk '{print $1 / 4}'`"
done | sed -n 's/^\(.*\/\)*\(.*\)/\2/p' | sed -E 's/[_]...*[fastq]//g'>>$outputorig

#