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
#-----------------------------quast_statistics---------------------------------

echo "Creating output directories..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"

# Define input files
genome_files=(
     "${basedir}/velvet/velvet_raw/hv_f_velvet_raw_genome_filtered_assembly_renamed.fasta"
     "${basedir}/spades/hv_f_spades_genome_filtered_assembly_renamed.fasta"
     "${basedir}/velvet/spades_corrected/hv_f_velvet_spades_genome_filtered_assembly_renamed.fasta"
     "${basedir}/soapdenovo2/soapdenovo_raw_assembly/hv_f_soapdenovo2_genome_filtered_assembly_renamed.fasta"
     "${basedir}/pilon/velvet_hv_f_pilon_genome_filtered_assembly_renamed.fasta"
     "${basedir}/pilon/spades/hv_f_spades_genome_filtered_assembly_renamed_pilon.fasta"
 )
bam_files=(
  "${basedir}/mapping_unmasked_genome/hv_f_velvet_raw_genome_filtered_assembly_renamed_mapped_reads_sorted.bam"
  "${basedir}/mapping_unmasked_genome/hv_f_spades_genome_filtered_assembly_renamed_pilon_mapped_reads_sorted.bam"
  "${basedir}/mapping_unmasked_genome/hv_f_velvet_spades_genome_filtered_assembly_renamed_mapped_reads_sorted.bam"
  "${basedir}/mapping_unmasked_genome/hv_f_soapdenovo2_genome_filtered_assembly_renamed_mapped_reads_sorted.bam"
  "${basedir}/mapping_unmasked_genome/velvet_hv_f_pilon_genome_filtered_assembly_renamed_mapped_reads_sorted.bam"
  "${basedir}/mapping_unmasked_genome/hv_f_spades_genome_filtered_assembly_renamed_pilon_mapped_reads_sorted.bam"
)


threads=56
forward_read="${basedir}/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz"
reverse_read="${basedir}/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz"
results="${basedir}/quast/unmasked_genome_stats"

echo Remove output directory if it already exists

if [ -d "${results}" ]; then
  rm -r "${results}"
fi

mkdir -p "${results}"
touch "${results}/quast_stats.err" "${results}/quast_stats.out"

# Run Quast
echo "Running quast..."

quast-lg.py "${genome_files[@]}" \
--output-dir "${results}" --min-contig 100 --threads "${threads}" \
--k-mer-stats --k-mer-size 51 --circos --gene-finding \
--conserved-genes-finding --est-ref-size 165 --use-all-alignments \
--est-insert-size 289 --report-all-metrics \
--pe1 "${forward_read}" \
--pe2 "${reverse_read}" \
--bam "${bam_files[0]}","${bam_files[1]}","${bam_files[2]}","${bam_files[3]}","${bam_files[4]}","${bam_files[5]}"  

#"${bam_files[0]}" "${bam_files[1]}" "${bam_files[2]}" "${bam_files[3]}" "${bam_files[4]}" 

echo "Quast assessment completed successfully !!!"

#--conserved-genes-finding 
# --features \
# quast-lg.py: The name of the script to be executed.
# ${velvet_file}: The path to the Velvet assembly file.
# ${spades_file}: The path to the SPAdes assembly file.
# ${soapdenovo_file}: The path to the SOAPdenovo2 assembly file.
# --output-dir "${results}": Specifies the directory where the output files will be written.
# --min-contig 100: Sets the minimum length of contigs to be considered during the analysis.
# --threads 50: Specifies the number of threads to use for parallel processing.
# --k-mer-stats: Enables the k-mer analysis statistics.
# --k-mer-size 51: Sets the k-mer size to 51 for k-mer analysis.
# --circos: Enables the generation of Circos plots.
# --gene-finding: Enables the gene finding mode.
# --conserved-genes-finding: Enables the conserved genes finding mode.
# --est-ref-size 165: Sets the estimated genome size to 165 Mb.
# --use-all-alignments: Enables the use of all alignments for metrics calculation.
# --est-insert-size 289: Sets the estimated insert size to 289 bp.
# --report-all-metrics: Enables the reporting of all available metrics.
# --pe1 "${forward_read}": Specifies the path to the first paired-end read file.
# --pe2 "${reverse_read}": Specifies the path to the second paired-end read file.
# --bam "${bam_files[@]}": Specifies the path to the BAM files containing mapped reads.