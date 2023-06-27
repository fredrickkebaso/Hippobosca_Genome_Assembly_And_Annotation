#!/bin/bash

#PBS -l select=1:ncpus=40:mpiprocs=40:mem=400gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00                                          
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/mapping/mapping_stats.out   
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/quast/mapping_stats.err    
#PBS -m abe                                                              
#PBS -M fredrickkebaso@gmail.com

set -eu

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/manase/"
results="${basedir}/assembly/arabiensis/mapping"

# Define input files (unmasked genomes)

reference="${basedir}/assembly/arabiensis/arabiensis.fna.gz"
genome_files=("${basedir}/assembly/arabiensis/arabiensis.fna.gz")

num_threads=40

# Raw reads
forward_read="${basedir}/raw-reads/microsporidi_poolA_1.fq"
reverse_read="${basedir}/raw-reads/microsporidi_poolA_2.fq"



# echo "Removing old output directory (if exists)..."
# if [ -d ${results} ]; then
#     rm -r ${results}
# fi


# # Create mapping_stats directory if it doesn't exist
# echo "Creating mapping_stats directory..."
# mkdir -p "${results}"
# touch "${results}/mapping_stats.err" "${results}/mapping_stats.out"

# # Activate required environment
# echo "Activating the quast environment..."
# env_name="quast"
# if ! conda info --envs | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi
# source "$(conda info --base)/etc/profile.d/conda.sh"
# conda activate "$env_name"

# # Index the genomes
# echo "Indexing the genomes..."
# # for file in "${genome_files[@]}"; do
# #     echo "Indexing '${file}'..."

# bwa index "${reference}"

# # done

# # Map reads to indexed assembly
# echo "Mapping reads to indexed assembly..."
# for file in "${genome_files[@]}"; do
#     echo "Mapping '${file}'..."
#     file_name=$(basename "${file%.*}")
#     echo "Mapping reads to ${file_name} assembly..."
#     bwa mem -t "${num_threads}" "${reference}" "${forward_read}" "${reverse_read}" > "${results}/${file_name}_mapped_reads.sam"
#     samtools view -@ "${num_threads}" -bS "${results}/${file_name}_mapped_reads.sam" | samtools sort -o "${results}/${file_name}_mapped_reads.sorted.bam" -
# done

# # Index the sorted BAM files
# echo "Indexing sorted BAM files..."
# for sorted_bam_file in "${results}"/*.sorted.bam; do
#     echo "Indexing '${sorted_bam_file}'..."
#     samtools index "${sorted_bam_file}"
# done

# # Echo completion message

# echo "Mapping, indexing and sorting completed successfully!"

# echo extracting mapped and unmapped reads

samtools view -h -F 4 "${results}"/arabiensis.fna_mapped_reads.sorted.bam > "${results}"/arabiensis.fna_mapped_reads_extracted.sam
samtools view -h -f 4 "${results}"/arabiensis.fna_mapped_reads.sorted.bam > "${results}"/arabiensis.fna_unmapped_reads_extracted.sam

# #convert to fastq

echo Converting tofastq...

samtools fastq -1 "${results}/mapped_Pool_J4-LB_1.fq.gz" -2 "${results}/mapped_Pool_J4-LB_2.fq.gz" -0 "${results}/other" -s "${results}/singletons" -n "${results}/arabiensis.fna_mapped_reads_extracted.sam"
samtools fastq -1 "${results}/umapped_Pool_J4-LB_1.fq.gz" -2 "${results}/umapped_Pool_J4-LB_2.fq.gz" -0 "${results}/other" -s "${results}/singletons" -n "${results}/arabiensis.fna_unmapped_reads_extracted.sam"



echo Done

