#!/bin/bash

#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/spades/spades.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/spades/spades.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N spades_hc_m

# ---------------- spades Assembly ----------------

# De novo genome assembly of short reads

# ---------------- Modules -----------------------

echo "Loading required modules..."

module load chpc/BIOMODULES
module add SPAdes/3.15.4

# ---------------- Inputs/Outputs/Parameters ------------------

echo "Initializing variables..."

basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male"
results="${basedir}/results/spades/symbionts"       # Path to the output directory
forward_read="${basedir}/results/kraken/hcamelina_male_unclassified_reads_1.fq"   # Path to the forward read file
reverse_read="${basedir}/results/kraken/hcamelina_male_unclassified_reads_2.fq"   # Path to the reverse read file
genome_name="hcamelina_m_spades_genome.fa" #Name you could like to call your assembled genome
kmer=51
threads=24
memory=110
echo "Removing old output directory (if exists)..."

# if [ -d ${results} ]; then
#     rm -r ${results}
# fi

# Create output directory

mkdir -p "${results}"

touch "${results}/spades.out" "${results}/spades.err"   # Create empty output files for spades

# Run spades

spades.py -o "${results}" -1 "${forward_read}" -2 "${reverse_read}" --threads ${threads} --memory ${memory}  -k "${kmer}" --cov-cutoff auto

#Rename the contigs 

cp "${results}/scaffolds.fasta" "${results}/${genome_name}" 

echo Assembly completed successfully!!