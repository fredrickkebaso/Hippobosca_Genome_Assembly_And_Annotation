#!/bin/bash

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"

# Define input files
genome_files=(
  "${basedir}/velvet/velvet_raw/hv_f_velvet_raw_genome.fa"
  "${basedir}/pilon/velvet_hv_f_pilon_genome.fa"
  "${basedir}/spades/hv_f_spades_genome.fa"
  "${basedir}/velvet/spades_corrected/hv_f_velvet_spades_genome.fa")
threads=72


for file in "${genome_files[@]}"; do
    # Get the file name without the extension
    file_name="$(basename "${file%.*}")"

    # Get the directory name where the filtered file will be saved
    out_dir="$(dirname "${file}")"

    # Get the size of the input file
    file_size="$(du -h "${file}" | cut -f1)"

    echo "Filtering ${file}..."
    
    # Filter out contigs shorter than 71bp and save to a new file
    awk '/^>/ {print seq;seq="";print;next}{seq=seq""$0}END{print seq}' "${file}" | awk 'length($0) >= 71 {print}' > "${out_dir}/${file_name}_filtered_assembly.fa"
    awk '/^>/ {print seq;seq="";print;next}{seq=seq""$0}END{print seq}' "${file}" | awk 'length($0) < 71 {print}' > "${out_dir}/${file_name}_short_contigs.fa"

    # Get the size of the filtered file
    filtered_size="$(du -h "${out_dir}/${file_name}_filtered_assembly.fa" | cut -f1)"

    # Get the total size of records filtered out
    filtered_out="$(du -h "${out_dir}/${file_name}_short_contigs.fa" | cut -f1)"

    echo "Input file size: ${file_size}"
    echo "Filtered file size: ${filtered_size}"
    echo "Size of records filtered out: ${filtered_out}"
done
