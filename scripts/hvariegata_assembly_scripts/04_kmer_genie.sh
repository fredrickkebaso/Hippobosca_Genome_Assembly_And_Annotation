#!/bin/bash 

#Determines kmer length

mkdir -p results/kmer-genie

echo Determining Best Kmer length using KmerGenie v 1.7051

for file in results/clean_reads/*.fq.gz

do

kmergenie-1.7051/kmergenie $file --diploid -k 149 -t 2 -o results/kmer-genie/hvariegata_f_genome

done;

echo Done.
