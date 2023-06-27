#!/bin/bash

#Filters short contigs, < 51

env_name="seqkit"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

echo Filtering contigs below 51 basepairs

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
results=${basedir}/spades
# Define input files  hvariegata_f_spades_genome.fa
genome_file=${results}/hvariegata_f_spades_genome.fa
threads=24
new_file=$(basename $genome_file .fa)

echo Number of original contigs $(grep -c "^>" ${genome_file})

seqkit seq --remove-gaps  --min-len 79 "${genome_file}" > ${results}/${new_file}_filtered_assembly.fa

echo Number of remaining contigs $(grep -c "^>" ${results}/${new_file}_filtered_assembly.fa)

echo Original genome size $(ls -lh ${genome_file})

echo New genome size $(ls -lh ${results}/${new_file}_filtered_assembly.fa)
