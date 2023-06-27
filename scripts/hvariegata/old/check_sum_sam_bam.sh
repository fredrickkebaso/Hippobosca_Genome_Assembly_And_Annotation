#!/bin/bash

#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping/mapping_stats/mapping_stats.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping/mapping_stats/mapping_stats.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N mapping_stats

set -euo pipefail

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define basedir

basedir=/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/velvet/mapping

# Create mapping_stats directory if it doesn't exist
mkdir -p "$basedir/mapping_stats"

touch "$basedir/mapping_stats/mapping_stats.out" "$basedir/mapping_stats/mapping_stats.err"

echo "Activating the environment..."

env_name="quast"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Loop through all BAM and SAM files in the basedir
for file in "$basedir"/*.bam "$basedir"/*.sam; do
  # Get filename without extension
  filename=$(basename -- "$file")
  filename="${filename%.*}"
  
  echo "Processing file: $filename"
  
  # Samtools quickcheck
  echo "Running Samtools quickcheck..."
  samtools quickcheck "$file" > "$basedir/mapping_stats/${filename}_quickcheck.txt"
  echo "Done with Samtools quickcheck."
  
  # Samtools flagstat
  echo "Running Samtools flagstat..."
  samtools flagstat "$file" > "$basedir/mapping_stats/${filename}_flagstat.txt"
  echo "Done with Samtools flagstat."
done

echo "Finished processing all files."
