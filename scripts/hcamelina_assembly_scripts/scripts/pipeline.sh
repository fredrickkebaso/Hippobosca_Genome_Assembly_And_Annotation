#!/bin/bash
module load fastqc/0.11.9
module load multiqc/1.14
module load trimgalore/0.6.5
module load cutadapt/3.4
module load velvet

#loading required modules

#concatenating reads

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

#Quality check of raw reads

echo Checking the quality of the reads using fastqc. Recomended version 0.11.9.

echo Found version `fastqc --version`

mkdir -p results/quality_reports/fastqc_raw_reads,multiqc_raw_reads

fastqc data/merged_raw_reads/*.fastq.gz -t 8 -o results/quality_reports/fastqc_raw_reads

#General Report using Multiqc version 1.11

echo Combining quality reports using multiqc. Reccomended version 1.13.

echo Found `multiqc --version`

multiqc -o results/quality_reports/multiqc_raw_reads results/quality_reports/fastqc_raw_reads

echo Quality check completed successfully !!!

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

#Running velvet

mkdir -p results/velvet_out/hvariegata_female_genome

echo Assembling Hvariegata_female_genome using velvet. Recommended Version 1.2.10.

velveth results/velvet_out/hvariegata_female_genome 51 \
-fastq.gz -shortPaired \
-separate \
results/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz \
results/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz && \
velvetg results/velvet_out/hvariegata_female_genome \
-exp_cov auto \
-cov_cutoff auto \
-ins_length 149 

echo Completed assembling hvariegata genome with Velvet successfully !!!!