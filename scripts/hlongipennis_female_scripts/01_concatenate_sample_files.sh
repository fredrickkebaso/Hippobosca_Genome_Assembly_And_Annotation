#!/bin/bash 

#Concatenates different samples files to one sample file

set -eu

echo Creating read-merging directory

mkdir -p data/merged_raw_reads

echo Done.

echo Concatenating Hcamelina samples...

# Hcamelina samples 
cat data/raw_reads/*S2-Hlongipenis-F1_S2_*_R1_001.fastq.gz >> data/merged_raw_reads/S2-Hlongipenis-F.R1.fastq.gz

cat data/raw_reads/*S2-Hlongipenis-F1_S2_*_R2_001.fastq.gz >> data/merged_raw_reads/S2-Hlongipenis-F.R2.fastq.gz

echo Done.

echo Total file size: `du -h data/merged_raw_reads`


echo Sample concatenation completed successfully !!!.