#!/usr/bin/env Rscript
#created 1.18.23
#last edited 1.18.23

#This R script is for the purpose of combining all of the outputs into one table. I had tried to do this with awk but it was proving too time-consuming for me to learn. 
#Here, each of the args are supplied by the snakemake. It will be important to keep track of these matching up with their inputs just so it's clear that everything is working. 
#another reason I just decided to use R was that I was having trouble figuring out how to keep NAs when using a join command. 

args = commandArgs(trailingOnly=TRUE)
#print(args)
#command to print out arguments

cmb_orig<-read.table(args[1], header=TRUE, sep="")
concat<-read.table(args[2], header=TRUE, sep="")
trim<-read.table(args[3], header=TRUE, sep="")
trimsumms<-read.table(args[4], header=TRUE, sep="")
qual<-read.table(args[5], header=TRUE, sep="")
align<-read.table(args[6], header=TRUE, sep="")
feature<-read.table(args[7], header=TRUE, sep="")

dfList<-list(cmb_orig, concat, trim, trimsumms, qual, align, feature)
n1<-Reduce(function(x, y) merge(x, y, all=TRUE), dfList)
write.table(n1, file=args[7], sep="\t", row.names=FALSE, col.names=TRUE, quote=FALSE)


