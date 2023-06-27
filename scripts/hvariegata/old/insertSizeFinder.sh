#!/bin/bash

# Calculates the insert size from raw reads.

# Set the '-e' and '-u' options to exit the script if any command fails or if any
# variable is undefined
set -eu

# Set the working directory where the input and output files will be stored
workdir="/scratch/fkebaso/hippo/hvariegata_female/results"

echo Estimating Insert metrics...

# Create a directory to store the insert metrics
mkdir -p ${workdir}/insert_metrics

# Loop through all files with the *_chopped_* pattern in the input directory
for file in ${workdir}/clean_reads/uncompressed/{001..021}; do
    # Extract the last part of the filename (e.g. '001' from '/path/to/001')
    part=$(basename $file)

    # Define the filenames of the R1 and R2 files for the current part
    R1="S1-Hvariegata-F.R1_val_1_chopped_R1.fq_part${part}"
    R2="S1-Hvariegata-F.R2_val_2_chopped_R2.fq_part${part}"

    # Create a directory for the current pair of reads to store the insert metrics

    mkdir -p ${workdir}/insert_metrics/${part}

    # Print a message showing which read pairs are being analyzed
    echo Analyzing R1: ${workdir}/clean_reads/uncompressed/${R1}
    echo Analyzing R2: ${workdir}/clean_reads/uncompressed/${R2}

    # Run the insert size finder script with the current pair of files
    python3 /home/fkebaso/hippo/hvariegata_female/scripts/InsertSizeFinder.py \
        -f ${workdir}/clean_reads/uncompressed/${R1} \
        -r ${workdir}/clean_reads/uncompressed/${R2} \
        -o ${workdir}/insert_metrics/${part}/insertmetrics.txt \
        -p ${workdir}/insert_metrics/${part}/insertmetrics_plot

    # Print a message indicating that the insert size calculation was completed
    echo "Insertsize metric calculation completed successfully for read-pair ${part} !!!"
done







