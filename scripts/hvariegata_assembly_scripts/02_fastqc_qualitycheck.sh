#!/bin/bash env

set -eu

#Quality check of rawa reads

echo Checks the quality of the reads using fastqc tool version 0.11.9

echo Found version `fastqc --version`

mkdir -p results/quality_reports/fastqc_raw_reads,multiqc_raw_reads

fastqc data/merged_raw_reads/*.fastq.gz -t 8 -o results/quality_reports/fastqc_raw_reads

#General Report using Multiqc version 1.11

echo Generating multiqc report multiqc version 1.11

multiqc -o results/quality_reports/multiqc_raw_reads results/quality_reports/fastqc_raw_reads
