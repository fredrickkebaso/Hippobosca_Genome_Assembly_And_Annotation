#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00                                          
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping_2/mapping_stats.out   
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping_2/mapping_stats.err    
#PBS -m abe                                                              
#PBS -M fredrickkebaso@gmail.com
#PBS -N mapping_hv

#Maps reads to the generated genome

set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
results="${basedir}/mapping_2"

# Define input files 
genome_files=("${basedir}/repeatmasker/spades/hvariegata_f_spades_genome.fa")
num_threads=56

# Raw reads
forward_read="${basedir}/spades/corrected/hvariegata_female_unclassified_reads_1.00.0_0.cor.fastq.gz" # Path to the forward read file
reverse_read="${basedir}/spades/corrected/hvariegata_female_unclassified_reads_2.00.0_0.cor.fastq.gz" # Path to the reverse read file

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"
touch "${results}/mapping_stats.err" "${results}/mapping_stats.out"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/bwa

echo Environment activated successfully!!

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

    echo Converting to bam, sorting and extracting mapping statistis....

    samtools view -@ "${num_threads}" -bS "${results}/${file_name}_mapped.sam" | samtools sort -o "${results}/${file_name}_mapped.sorted.bam" -
    samtools flagstat "${results}/${file_name}_mapped.sorted.bam" > "${results}/${file_name}_mapping_stats.txt"
    samtools coverage "${results}/${file_name}_mapped.sorted.bam" > "${results}/${file_name}_coverage_stats.txt"
    samtools depth "${results}/${file_name}_mapped.sorted.bam" > "${results}/${file_name}_depth_stats.txt"

done

# Index the sorted BAM files
echo "Indexing sorted BAM files..."
for sorted_bam_file in "${results}"/*.sorted.bam; do
    echo "Indexing '${sorted_bam_file}'..."
    samtools index "${sorted_bam_file}"
done

# Echo completion message

echo "Mapping, indexing and sorting completed successfully!"



