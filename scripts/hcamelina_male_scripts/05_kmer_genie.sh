#!/bin/bash 

#Determines kmer length

echo Determining Best Kmer length using KmerGenie v 1.7044

for file in results/clean_reads/*.fq.gz

do

kmergenie $file \
--diploid \
-k 141 \
-t 8 \
-o results/kmer-genie/
done;

#--diploid: Tells KmerGenie to optimize k-mer size for a diploid genome.
#-k 141: Specifies the maximum k-mer size to optimize for. KmerGenie will test a range of k-mer sizes up to this value.
#-t 8: Specifies the number of threads to use. KmerGenie will run in parallel on this many threads to speed up the analysis.
#-o results/kmer-genie/: Specifies the output directory where KmerGenie will save its results.
#N/B: Can be installed with: conda install -c biobuilds kmergenie



