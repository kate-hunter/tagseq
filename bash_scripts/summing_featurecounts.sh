#!/bin/bash
#created 1.13.23
#last edited 1.17.23

set -e

orig=$1
outputorig=$2

echo "samples featurecounts_assigned featurecounts_unassigned_multimapping featurecounts_unassigned_nofeatures">$outputorig

for fname in $orig/*.txt.summary; do
 echo "$fname `sed -n '2p;8p;11p' $fname| grep -o '[0-9]\+'| paste - - - -`"
done | sed -n 's/^\(.*\/\)*\(.*\)/\2/p'| sed -E 's/[_]...*txt.summary//g' >> $outputorig

#
