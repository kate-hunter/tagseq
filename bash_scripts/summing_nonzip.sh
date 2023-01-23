#!/bin/bash
#created 1.9.23
#last edited 1.17.23

set -e

orig=$1
header=$2
outputorig=$3
endvar=$4

echo "samples $header">$outputorig

for fname in $orig/*$endvar; do
 echo "$fname `wc -l $fname | awk '{print $1 / 4}'`"
done | sed -n 's/^\(.*\/\)*\(.*\)/\2/p' | sed -E "s/[_]...*[$endvar]//g">>$outputorig

#