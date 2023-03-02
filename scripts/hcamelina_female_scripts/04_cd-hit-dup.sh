#!/bin/bash

set -eu

#cd-hit-dup is a simple tool for removing duplicates from sequencing reads, with optional step to detect and remove chimeric reads.

mkdir -p results/de_duplicated_reads
mkdir -p results/quality_reports/{fastqc_deduplicated_reads,multiqc_deduplicated_reads}

echo De_duplicating cleaned reads using cd-hit. Recommended version 4.8.1.

cd-hit-dup \
-i results/clean_reads/S3-Hcamelina-F.R1_val_1.fq \
-o results/de_duplicated_reads/S3-Hcamelina-F.R1.dedup.fq \
-i2 results/clean_reads/S3-Hcamelina-F.R2_val_2.fq \
-o2 results/de_duplicated_reads/S3-Hcamelina-F.R2.dedup.fq \

echo Done.

#Checks the quality of the reads using fastqc tool version 0.11.9

echo Evaluating the quality of the de_duplicated_reads using fastqc. Reccomended version 0.11.9.

echo Found version `fastqc --version

fastqc results/de_duplicated_reads/*.fq -t 8 -o results/quality_reports/fastqc_deduplicated_reads

#General Report using Multiqc version 1.9

echo Combining quality reports using multiqc. Reccomended 1.13.

echo Found `multiqc -version`

multiqc -o results/quality_reports/multiqc_deduplicated_reads results/quality_reports/fastqc_deduplicated_reads

echo Done.
