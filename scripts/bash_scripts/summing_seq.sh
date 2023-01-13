#!/bin/bash
#created 1.9.23
#last edited 1.9.23

orig=$1
header=$2
outputorig=$3
smps="samples"

for fname in $orig/*.fastq; do
 echo "$fname `wc -l $fname | awk '{print $1 / 4}'`"
done | sed -n 's/^\(.*\/\)*\(.*\)/\2/p' | sed -E 's/[_]...*fastq//g' >interrim 

echo $smps $header | cat - interrim > $outputorig
rm interrim