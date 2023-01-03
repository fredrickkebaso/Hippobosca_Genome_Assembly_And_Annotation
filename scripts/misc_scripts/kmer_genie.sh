#!/bin/bash 

#Determines kmer length

for file in results/clean_reads/*.fq.gz

do

kmergenie $file --diploid -k 139 -o results/kmer-genie/

done;