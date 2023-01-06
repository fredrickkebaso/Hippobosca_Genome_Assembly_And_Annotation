#!/bin/bash 

#Concatenates different samples files to one sample file

set -eu

mkdir -p data/merged_raw_reads

echo Done.

echo Concatenating Hvariegata samples...

# Hvariegata samples 
cat data/raw_reads/*S1-Hvariegata-F1_S1_*_R1_001.fastq.gz >> data/merged_raw_reads/S1-Hvariegata-F.R1.fastq.gz

cat data/raw_reads/*S1-Hvariegata-F1_S1_*_R2_001.fastq.gz >> data/merged_raw_reads/S1-Hvariegata-F.R2.fastq.gz

echo Done.

echo Total file size: `du -h data/merged_raw_reads`


echo Sample concatenation completed successfully !!!.