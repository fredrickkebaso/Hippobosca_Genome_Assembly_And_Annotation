#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=18:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/clean_reads/clean.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/clean_reads/clean.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N trim_galore

# Cleaning data removing adapters, trimming low quality bases, and re-evaluating the quality of the cleaned reads

set -eu

# ---------------- Contamination check ----------------

# Contamination check

# ---------------- Modules -----------------------
echo "Loading required modules/Activating required environment..."


source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/trimgalore

echo Environment activated !!!


# ---------------- Requirements ------------------

echo "Creating output variables..."

# Initializing variables
basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results"
reads="${basedir}/data/merged_raw_reads"
results="${basedir}/clean_reads"
threads=8

# Create output and quality report directories
mkdir -p "${results}"
mkdir -p ${basedir}/quality_reports/{fastqc_clean_reads,multiqc_clean_reads}
touch ${results}/clean.out ${results}/clean.err

echo "Cleaning data using trim_galore"

# Run trim_galore for data cleaning
echo "Running trim_galore..."
trim_galore \
--paired "${reads}"/*.R1.fastq.gz "${reads}"/*.R2.fastq.gz \
--fastqc_args "--outdir ${basedir}/quality_reports/fastqc_clean_reads" \
--quality 28 \
--length 30 \
--cores "${threads}" \
--output_dir "${results}"

echo "Data cleaning with trim_galore completed successfully."

echo Cleaning data done...

# Combine quality reports using MultiQC
echo "Combining quality reports using MultiQC..."
multiqc -o "${basedir}/quality_reports/multiqc_clean_reads" "${basedir}/quality_reports/fastqc_clean_reads"

echo "Quality reports combined successfully."

echo "Data cleaning completed successfully!"
