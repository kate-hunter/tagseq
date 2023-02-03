#!/bin/bash
#created 1.9.23
#last edited 1.9.23

#this script is combining the summ.txt 
#output headers come from perl script in tagseq_clipper.anna_khedited.pl

orig=$1
outputorig=$2

echo "samples trimmtotal trimmgoods dups noheader N.in.header">$outputorig

for fname in $orig/*.cmb.fastq.gz.summ.txt; do
 echo "$fname `awk -F'[^0-9]*' '{print $5, $6, $7, $8, $9}' $fname | paste - - - -`"
done | sed -n 's/^\(.*\/\)*\(.*\)/\2/p'| sed -E 's/[_]...*.cmb.fastq.gz.summ.txt//g' >>$outputorig


#| sed -E 's/[_]...*[fastq]//g'