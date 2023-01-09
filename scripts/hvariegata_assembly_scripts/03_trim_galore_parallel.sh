#!/bin/bash

set -eu

echo "Cleaning data using trim_galore v 0.6.6 ..."

echo Found version `trim_galore --version`

mkdir -p results/quality_reports/{fastqc_clean_reads,multiqc_clean_reads}

trim_galore \
--paired data/merged_raw_reads/*.R1.fastq.gz data/merged_raw_reads/*.R2.fastq.gz \
--cores 8 \
--length 1 \
--phred33 \
--nextera \
--fastqc_args "--outdir results/quality_reports/fastqc_clean_reads" \
--output_dir results/clean_reads

echo Done.

echo Generating report using Multiqc version 1.11


multiqc -o results/quality_reports/multiqc_clean_reads results/quality_reports/fastqc_clean_reads

echo Done.





