#!/bin/bash

set -eu

echo Quality checking of the raw reads

echo Loading required modules...

module load chpc/BIOMODULES
module load fastqc/0.11.9
module load MultiQC

#Defining variables

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
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
