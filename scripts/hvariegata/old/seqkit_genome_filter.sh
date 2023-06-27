#!/bin/bash

# Activate required environment
env_name="quast"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/combined_analysis"

# Define input files
genome_files=("${basedir}/genome/spades/hcamelina_f_spdes_genome.fa")

threads=24

for file in "${genome_files[@]}"; do
    # Get the file name without the extension
    file_name="$(basename "${file%.*}")"
    original_size=$(du -sh "${file}" | cut -f2)

    # Get the directory name where the filtered file will be saved
    out_dir="$(dirname "${file}")"

    echo "Filtering ${file}..."

    # Filter out contigs shorter than 71bp and save to a new file
    seqkit seq --remove-gaps  --min-len 51 "${file}" > "${out_dir}/${file_name}_filtered_assembly.fa"
    new_file="${out_dir}/${file_name}_filtered_assembly.fa"

    # Get the size of the filtered file
    filtered_size="$(stat -c %s "${out_dir}/${file_name}_filtered_assembly.fa")"
    filtered_size_human_readable="$(numfmt --to=iec --suffix=B "${filtered_size}")"

    # Get the total size of records filtered out
    filtered_out="$(seqtk comp "${out_dir}/${file_name}_filtered_assembly.fa" | awk 'NR==2 {print $2}')"

    echo "Original file size: ${original_file}"
    echo "New file: ${new_file}"
    echo "Filtered file size: ${filtered_size_human_readable}"
    echo "Total size of records filtered out: ${filtered_out}"
    echo ""
done
