#!/bin/bash

set -eu

# Concatenates different sample files to create forward and reverse read files

basedir="/mnt/lustre/users/fkebaso/hippo"

forward_reads=("${basedir}/data/raw_reads/"*S1-Hvariegata-F1_S1_*_R1_001.fastq.gz)
reverse_reads=("${basedir}/data/raw_reads/"*S1-Hvariegata-F1_S1_*_R2_001.fastq.gz)

results="${basedir}/hvariegata_female/results/data/merged_raw_reads"

forward_output="${results}/S1-Hvariegata-F.R1.fastq.gz"
reverse_output="${results}/S1-Hvariegata-F.R2.fastq.gz"

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
# if [ -d "${results}" ]; then
#     rm -r "${results}"
# fi

# Create output directory
mkdir -p "${results}"

echo "Concatenating hvariegata samples..."

# Concatenate forward reads
echo "Concatenating forward reads..."
cat "${forward_reads[@]}" >> "${forward_output}"

# Concatenate reverse reads
echo "Concatenating reverse reads..."
cat "${reverse_reads[@]}" >> "${reverse_output}"

echo "Concatenation completed."

# Calculate total file sizes
forward_size=$(du -h "${forward_output}" | cut -f1)
reverse_size=$(du -h "${reverse_output}" | cut -f1)

echo "Total file size - Forward reads: ${forward_size}"
echo "Total file size - Reverse reads: ${reverse_size}"

echo "Sample concatenation completed successfully !!!."
