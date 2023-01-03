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

echo Concatenating Hlongipennis samples...

# Hlongipennis samples 

cat data/raw_reads/*S2-Hlongipenis-F1_S2_*_R1_001.fastq.gz >> data/merged_raw_reads/S2-Hlongipenis-F.R1.fastq.gz

cat data/raw_reads/*S2-Hlongipenis-F1_S2_*_R2_001.fastq.gz >> data/merged_raw_reads/S2-Hlongipenis-F.R2.fastq.gz

echo Done.

echo Concatenating Hcamelina-female samples...
# Hcamelina samples (female)

cat data/raw_reads/*S3-Hcamelina-F2_S3_*_R1_001.fastq.gz >> data/merged_raw_reads/S3-Hcamelina-F.R1.fastq.gz

cat data/raw_reads/*S3-Hcamelina-F2_S3_*_R2_001.fastq.gz >> data/merged_raw_reads/S3-Hcamelina-F.R2.fastq.gz

echo Done.

echo Concatenating Hcamelina-male samples...

#Hcamelina samples (male)

cat data/raw_reads/S4-Hcamelina-M2_S4_*_R1_001.fastq.gz >> data/merged_raw_reads/S4-Hcamelina-M.R1.fastq.gz

cat data/raw_reads/S4-Hcamelina-M2_S4_*_R2_001.fastq.gz >> data/merged_raw_reads/S4-Hcamelina-M.R2.fastq.gz

echo Done.

echo Total file size: `du -h data/merged_raw_reads`


echo Sample concatenation completed successfully !!!.