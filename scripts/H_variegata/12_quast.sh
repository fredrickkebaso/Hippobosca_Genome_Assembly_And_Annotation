#PBS -l select=1:ncpus=50:mpiprocs=50:mem=500gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=10:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/quast/spades/quast_stats.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/quast/spades/quast_stats.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N quast_stats_hv

#-----------------------------quast_statistics---------------------------------

echo "Creating output directories..."

# Define base directory
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"

# Define input files
genome_files=("${basedir}/results/repeatmasker/spades/hvariegata_f_spades_genome.fa" )
threads=50
forward_read="${basedir}/results/spades/corrected/hvariegata_female_unclassified_reads_1.00.0_0.cor.fastq.gz" # Path to the forward read file
reverse_read="${basedir}/results/spades/corrected/hvariegata_female_unclassified_reads_2.00.0_0.cor.fastq.gz" # Path to the reverse read file
results="${basedir}/results/quast/spades"

mkdir -p "${results}"

touch "${results}/quast_stats.err" "${results}/quast_stats.out"

echo "Loading required modules/Activating required environment..."

echo Conda activating environment...

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/quast

echo Environment activated !!!

# Run Quast
echo "Running quast..."

quast-lg.py "${genome_files[@]}" \
--output-dir "${results}" --min-contig 100 --threads "${threads}" \
--k-mer-stats --k-mer-size 51 --circos --gene-finding \
--conserved-genes-finding --est-ref-size 165 --use-all-alignments \
--est-insert-size 289 --report-all-metrics --eukaryote \
--pe1 "${forward_read}" \
--pe2 "${reverse_read}" 

echo "Quast assessment completed successfully !!!"
