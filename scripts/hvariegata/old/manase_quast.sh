#!/bin/bash

#PBS -l select=1:ncpus=50:mpiprocs=50:mem=800gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=10:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/quast/repeatmasked/quast_stats.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/quast/repeatmasked/quast_stats.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N quast_stats

#-----------------------------quast_statistics---------------------------------

echo "Creating output directories..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/manase/assembly"
genomes="${basedir}/results"
results="${genomes}/quast"

# Define input files
genome_files=("${genomes}/velvet/microsporidia_Mb_genome.fa" "${genomes}/spades/scaffolds.fasta" "${genomes}/abyss/MB-scaffolds.fa" )

threads=50
forward_read="${basedir}/arabiensis/mapping/unmapped_Pool_J4-LB_1.fq.gz"
reverse_read="${basedir}/arabiensis/mapping/unmapped_Pool_J4-LB_2.fq.gz"

# echo Remove output directory if it already exists

# if [ -d "${results}" ]; then
#   rm -r "${results}"
# fi

mkdir -p "${results}"
touch "${results}/quast_stats.err" "${results}/quast_stats.out"

echo  Activate required environment

env_name="quast"
if ! conda info --envs | grep -q "^$env_name"; then
  echo "Error: the environment '$env_name' does not exist."
  exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Run Quast
echo "Running quast..."

quast "${genome_files[@]}" \
--output-dir "${results}" --min-contig 100 --threads "${threads}" \
--k-mer-stats --k-mer-size 41 --circos --gene-finding \
--conserved-genes-finding --est-ref-size 4 --use-all-alignments \
--est-insert-size 235 --report-all-metrics --fungus \
--pe1 "${forward_read}" \
--pe2 "${reverse_read}" 



#--bam "${bam_files[0]}","${bam_files[1]}","${bam_files[2]}","${bam_files[3]}","${bam_files[4]}","${bam_files[5]}"  

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