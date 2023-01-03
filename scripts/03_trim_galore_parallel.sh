#!/bin/bash 

set -eu

echo "Cleaning data using trim_galore in a parallel mode..."

mkdir -p results/quality_reports/{quality_clean_reads,multiqc_clean_reads}

ls -1 data/merged_raw_reads/*.fastq.gz | \
cut -d. -f1 | sort | uniq | \
parallel -j 4 \
trim_galore \
--paired {}.R1.fastq.gz {}.R2.fastq.gz \
--quality 28 \
--clip_R1 10 \
--clip_R2 10 \
--length 20 \
--cores 8 \
--phred33 \
--output_dir results/clean_reads 

echo Done.

#Checks the quality of the reads using fastqc tool version 0.11.9

echo Evaluating the quality of the cleaned reads...

fastqc results/clean_reads/*.gz -t 8 -o results/quality_reports/quality_clean_reads

#General Report using Multiqc version 1.9

multiqc -o results/quality_reports/multiqc_clean_reads results/quality_reports/quality_clean_reads

echo Done.


