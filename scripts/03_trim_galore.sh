#!/bin/bash

set -eu

echo CLEANING DATA USING TRIMM_GALORE

#Trim_galore cleans reads and generates  a  fastqc report of the cleaned reads 

mkdir -p  ${PWD}/results/quality_recheck 

for f_read in ${PWD}/raw_reads/*_R1_001.fastq.gz

do

r_read=${f_read/_R1_/_R2_} 

trim_galore \
-fastqc_args "--outdir ${PWD}/results/quality_recheck" \
--quality 28 \
--clip_R1 10 \
--clip_R2 10 \
--length 20 \
--cores 4 \
--phred33 \
--output_dir ${PWD}/results/clean_reads \
--path_to_cutadapt /opt/apps/cutadapt/3.4/bin/cutadapt \
--paired ${f_read} ${r_read}

done;

#Multiqc report

mkdir -p ${PWD}/results/quality_cleaned_reads/multiqc_report

multiqc -o ${PWD}/results/quality_cleaned_reads/multiqc_report ${PWD}/results/quality_cleaned_reads/quality_recheck

echo Data cleaning completed !!!
