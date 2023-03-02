#!/bin/bash 

#Determines kmer length
echo Determining Best Kmer length using KmerGenie v 1.7051

for file in results/clean_reads/*.fq.gz

do

/home/kebaso/Documents/projects/hippo/kmergenie-1.7051/kmergenie $file \
--diploid \
-k 141 \
-t 2 \
-o results/kmer-genie/hcamelina_f_genome

#-k - largest k-mer size to consider (default: 121)
done;
