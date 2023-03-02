#!/bin/bash

#Cleaning data removing adapters, trimming low quality bases and re-evaluating the quality of the cleaned reads
set -eu

module load trimgalore/0.6.5
module load cutadapt/3.4

echo Cleaning data using trim_galore. Recommended version 0.6.7

echo Found version `trim_galore --version`

mkdir -p results/quality_reports/{fastqc_clean_reads,multiqc_clean_reads}

trim_galore \
--paired data/merged_raw_reads/*.R1.fastq.gz data/merged_raw_reads/*.R2.fastq.gz \
--fastqc_args "--outdir results/quality_reports/fastqc_clean_reads" \
--quality 25 \
--length 15 \
--phred33 \
--nextera \
--cores 8 \
--output_dir results/clean_reads

echo Done.

echo Combining quality reports using multiqc. Reccomended 1.13.

echo Found `multiqc --version`

multiqc -o results/quality_reports/multiqc_clean_reads results/quality_reports/fastqc_clean_reads

echo Done.

echo Data cleaning completed successfully !!!





