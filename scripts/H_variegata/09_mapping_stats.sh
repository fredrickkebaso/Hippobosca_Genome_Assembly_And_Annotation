#!/bin/bash

# For extracting mapping statistics of the reads back to the genome

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
bam_files=("${basedir}/mapping/"*.bam)
results="${basedir}/mapping_stats"

mkdir -p "${results}"

echo "Loading required modules/Activating required environment..."

env_name="samtools"

source /home/fkebaso/miniconda3/envs/mamba/bin/activate /home/fkebaso/miniconda3/envs/mamba/envs/${env_name}

echo "Mamba environment activated!"

echo Running samtools...

for bam in "${bam_files[@]}"
do
  file_name=$(echo "$bam" | cut -d "_" -f1-5)
  file=$(basename "$file_name")
  
  samtools stats -@ 24 "$bam" > "${results}/${file}.stats"
  samtools depth "$bam" > "${results}/${file}_coverage.txt"

done


echo "${bam_files[@]}" > "${results}/bam_file_list"

samtools coverage --bam-list "${results}/bam_file_list" --depth 0 --output "${results}/Genome_coverage.stats"
