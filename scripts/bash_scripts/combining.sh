#!/bin/bash
#created 1.9.23
#last edited 1.11.23

#Notes: The goal of this bash script is just to combine the rows that have the same name


#step 1 is to change sample names with the below sed command, 
#the below will combine the counts for both lanes so I can combine this with the concatenated table to make sure those all are correct values as well
input_seqs1n2=$1
output_cmbseqs=$2

awk 'NR==1{print;next} {if ($1 in seen); else b[c++]=$1; seen[$1]=1; for (i=2;i<=NF;i++) {a[$1","i]+=$i}} END{for (j=0;j<c;j++) {s=b[j]; for (i=2;i<=NF;i++){s=s" "a[b[j]","i]}; print s}}' $input_seqs1n2 > $output_cmbseqs


