#!/bin/bash
#PBS -l select=1:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/pjepchirchir/stomoxys/results/trimgalore/trimgalore.out
#PBS -e /mnt/lustre/users/pjepchirchir/stomoxys/results/trimgalore/trimgalore.err
#PBS -m abe
#PBS -M parcelmaiyo@gmail.com
#PBS -N trimgalore

#Cleaning data removing adapters, trimming low quality bases and re-evaluating the quality of the cleaned reads

module load chpc/BIOMODULES
module add trim_galore/0.6.5
module add cutadapt/3.4
module add  MultiQC 

echo Cleaning data using trim_galore. Recommended version 0.6.7

echo Found version `trim_galore --version`

mkdir -p results/quality_reports/{fastqc_clean_reads,multiqc_clean_reads}

trim_galore \
--paired data/SIndica-M_S1_L003_R1_001.fastq.gz data/SIndica-M_S1_L003_R2_001.fastq.gz \
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
