#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=18:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/quality_reports/fastqc.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/quality_reports/fastqc.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N fastqc

set -eu

echo Quality checking of the raw reads

echo Loading required modules...

module load chpc/BIOMODULES
module load fastqc/0.11.9

echo Activating relevant environment...

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/trimgalore

echo Environment activated !!!

#Defining variables

basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results"
reads="${basedir}"/data/merged_raw_reads/*.fastq.gz
results="${basedir}/quality_reports"
threads=24

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
# if [ -d ${results} ]; then
#     rm -r ${results}
# fi

echo Creating output directories

mkdir -p ${results}/{fastqc_raw_reads,multiqc_raw_reads}

#Quality check of raw reads

echo Checking the quality of the reads using fastqc. Recomended version 0.11.9.

echo Found `fastqc --version`

fastqc ${reads} -t ${threads} -o ${results}/fastqc_raw_reads

#General Report using Multiqc version 1.11

echo Combining quality reports using multiqc...

echo Found `multiqc --version`

multiqc -o ${results}/multiqc_raw_reads ${results}/fastqc_raw_reads

echo Quality check completed successfully !!!
