#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00                                          
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping/mapping_stats.out   
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping/mapping_stats.err    
#PBS -m abe                                                              
#PBS -M fredrickkebaso@gmail.com

#Maps reads to the generated genome

set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
results="${basedir}/mapping"

# Define input files (unmasked genomes)
genome_files=(
  "${basedir}/spades/hvariegata_f_spades_genome_filtered_assembly_renamed.fa"
  "${basedir}/velvet/hvariegata_f_velvet_genome_filtered_assembly_renamed.fa"
  )
num_threads=56

# Raw reads
forward_read="${basedir}/kraken/hvariegata_female_unclassified_reads_1.fq"   # Path to the forward read file
reverse_read="${basedir}/kraken/hvariegata_female_unclassified_reads_2.fq"   # Path to the reverse read file

echo "Removing old output directory (if exists)..."
# if [ -d ${results} ]; then
#     rm -r ${results}
# fi

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"
touch "${results}/mapping_stats.err" "${results}/mapping_stats.out"

# Activate required environment
echo "Activating the quast environment..."
env_name="quast"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" "${forward_read}" "${reverse_read}" > "${results}/${file_name}_mapped.sam"
    samtools view -@ "${num_threads}" -bS "${results}/${file_name}_mapped.sam" | samtools sort -o "${results}/${file_name}_mapped.sorted.bam" -
done

# Index the sorted BAM files
echo "Indexing sorted BAM files..."
for sorted_bam_file in "${results}"/*.sorted.bam; do
    echo "Indexing '${sorted_bam_file}'..."
    samtools index "${sorted_bam_file}"
done

# Echo completion message

echo "Mapping, indexing and sorting completed successfully!"



