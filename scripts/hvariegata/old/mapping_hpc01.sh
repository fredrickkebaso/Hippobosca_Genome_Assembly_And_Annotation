#!/bin/bash

#PBS -l select=3:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping/mapping_stats.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/quast/mapping_stats.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N mapping_stats

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/scratch/fkebaso/hippo/hvariegata_female/results"
mapping_dirs="${basedir}/mapping/spades"

# Define input files
velvet_file="${basedir}/repeatmasker/velvet/hvariegata_f_genome_velvet_fa.masked"
spades_file="${basedir}/repeatmasker/spades/hvariegata_f_genome_spades_scaffolds.fasta.masked"
soapdenovo_file="${basedir}/repeatmasker/soapdenovo2/hvariegata_f_genome_soapdenovo_scafSeq.fa.masked"
pilon_file="${basedir}/repeatmasker/pilon/hvariegata_f_genome_pilon.fasta.masked"
forward_read="${basedir}/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz"
reverse_read="${basedir}/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${mapping_dirs}"
touch "${mapping_dirs}/mapping_stats.err" "${mapping_dirs}/mapping_stats.out"

# Activate required environment
echo "Activating the quast environment..."
env_name="quast"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

files=("${velvet_file}" "${spades_file}" "${soapdenovo_file}" "${pilon_file}")
num_threads=72

Index the genomes...
echo "Indexing the genomes..."
for file in "${files[@]}"; do
    bwa index "${file}"
done

# Map reads to the indexed assembly 
echo "Mapping reads to indexed assembly..."


# bwa mem -t "${num_threads}" "${velvet_file}" "${forward_read}" "${reverse_read}" > "${mapping_dirs}/hvariegata_f_genome_velvet_mapped_reads.sam"

# samtools view -bS "${mapping_dirs}/hvariegata_f_genome_velvet_mapped_reads.sam" | samtools sort -o "${mapping_dirs}/hvariegata_f_genome_velvet_mapped_reads.sorted.bam" -



for file in "${files[@]}"; do
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" "${forward_read}" "${reverse_read}" > "${mapping_dirs}/${file_name}_mapped_reads.sam"
    samtools view -bS "${mapping_dirs}/${file_name}_mapped_reads.sam" | samtools sort -o "${mapping_dirs}/${file_name}_mapped_reads.sorted.bam" -
done

# Index the sorted BAM files
echo "Indexing sorted BAM files..."
for sorted_bam_file in "${mapping_dirs}"/*.sorted.bam; do
    samtools index "${sorted_bam_file}"
done

echo "Mapping, indexing and sorting completed successfully!"
