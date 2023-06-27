#!/bin/bash

#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00                                          
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping/mapping_stats.out   
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/quast/mapping_stats.err    
#PBS -m abe                                                              
#PBS -M fredrickkebaso@gmail.com

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
results="${basedir}/mapping_unmasked_genome"

# Define input files (unmasked genomes)
genome_files=(
    "${basedir}/pilon/spades/hv_f_spades_genome_filtered_assembly_renamed_pilon.fasta"
    "${basedir}/velvet/velvet_raw/hv_f_velvet_raw_genome_filtered_assembly_renamed.fasta"
    "${basedir}/spades/hv_f_spades_genome_filtered_assembly_renamed.fasta"
    "${basedir}/velvet/spades_corrected/hv_f_velvet_spades_genome_filtered_assembly_renamed.fasta"
    "${basedir}/soapdenovo2/soapdenovo_raw_assembly/hv_f_soapdenovo2_genome_filtered_assembly_renamed.fasta"
    "${basedir}/pilon/velvet_hv_f_pilon_genome_filtered_assembly_renamed.fasta"
)

num_threads=56


# Raw reads
forward_read="${basedir}/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz"
reverse_read="${basedir}/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz"

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
    bwa mem -t "${num_threads}" "${file}" "${forward_read}" "${reverse_read}" > "${results}/${file_name}_mapped_reads.sam"
    samtools view -@ "${num_threads}" -bS "${results}/${file_name}_mapped_reads.sam" | samtools sort -o "${results}/${file_name}_mapped_reads.sorted.bam" -
done

# Index the sorted BAM files
echo "Indexing sorted BAM files..."
for sorted_bam_file in "${results}"/*.sorted.bam; do
    echo "Indexing '${sorted_bam_file}'..."
    samtools index "${sorted_bam_file}"
done

# Echo completion message
echo "Mapping, indexing and sorting completed successfully!"



