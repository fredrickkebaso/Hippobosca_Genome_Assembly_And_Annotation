#!/bin/bash 

#Concatenates different samples files to one sample file

set -eu

#Provide the path to the raw reads as a	commandline argument

data="$1"

echo Creating read-merging directory

mkdir -p data/merged_raw_reads

echo Done.

echo Concatenating hcamelina female samples...

cat $data/*S3-Hcamelina-F2_S3_*_R1_001.fastq.gz >> data/merged_raw_reads/S3-Hcamelina-F.R1.fastq.gz

cat $data/*S3-Hcamelina-F2_S3_*_R2_001.fastq.gz >> data/merged_raw_reads/S3-Hcamelina-F.R2.fastq.gz

echo Done.

echo Total file size: `du -h data/merged_raw_reads`


echo Sample concatenation completed successfully !!!.
