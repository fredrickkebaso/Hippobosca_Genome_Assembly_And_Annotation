#!/bin/bash

set -eu

#For assessment of genome quality and completeness using 
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results="${basedir}/results/busco/velvet_spades_corrected"
genome="${basedir}/results//velvet/spades_corrected/hvariegata_f_spades_genome.fa"

# Create the output directory

echo Creating output directory 

mkdir -p "{results}"

echo Activating required environment...

echo "Loading required modules/Activating required environment..."

env_name="busco_env"

if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

echo Computing hvariegata_f_genome_stats using BUSCO. Recommended version 5.4.5...

echo Found `busco --version` proceeding with metric computation...

busco \
--in "${genome}" \
--lineage arthropoda_odb10 \
--out genome_stats \
--out_path "{results}" \
--mode genome \
--augustus \
--cpu "${threads}" \
--download_path "{results}" \
--scaffold_composition \
--update-data

echo Done

echo Completed BUSCO metrics computation successfully !!!


