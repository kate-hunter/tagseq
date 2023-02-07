#!/bin/bash
#created 1.13.23
#last edited 1.17.23
#bascially, I need this bash script to first collect the info on the "number of input reads" and collect those with their info
#then I want to make a separate table that has the "aligned reads" and then I want to join those together

set -e

orig=$1
outputorig=$2

echo "samples alignment_input_reads alignment_avgreadlength alignment_uniquelymapped_reads alignment_numberofreadsmultiloci alignment_unmaptooshort">$outputorig

for fname in $orig/*/*.final.out; do
 echo "$fname `sed -n '6p;7p;9p;24p;31p' $fname| grep -o '[0-9]\+'| paste - - - - - -`"
done | sed -n 's/^\(.*\/\)*\(.*\)/\2/p'| sed -E 's/[_]...*Log.final.out//g' >> $outputorig


