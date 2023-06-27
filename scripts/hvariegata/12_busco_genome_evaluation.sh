#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:mem=400gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results_old/busco/genome_quality/genome.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results_old/busco/genome_quality/genome.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N busco_genome_quality

set -eu

#Initalizing variables

basedir="/home/pjepchirchir/lustre/fkebaso/hippo/hvariegata_female"
results="${basedir}/results/busco/genome_quality"
predicted_genes=("${basedir}/results/repeatmasker/hvariegata_f_spades_genome.fa" "${basedir}/results/repeatmasker/velvet/hvariegata_f_velvet_genome.fa")
mode="genome"
threads=24
lineages=("metazoa_odb10"
          "arthropoda_odb10"
          "insecta_odb10"
          "diptera_odb10")

echo "Loading required modules/Activating required environment..."

echo Setting up required environment...

#Load the required modules

module load chpc/BIOMODULES
module add busco/5.4.5

# # Creating output directory

mkdir -p "${results}"

# echo "Running Busco gene evaluation..."

# Download lineages
for genome in "${predicted_genes[@]}"; do
    out_dir=$(basename "${genome}" .fa)
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
        busco --in "${genome}" \
        --lineage "${lineage}" \
        --evalue 0.001  \
        --augustus \
        --augustus_species "fly" \
        --out "${lineage}_stats" \
        --mode ${mode} --cpu "${threads}" \
        --datasets_version odb10 \
        --download_path ${results}/${out_dir} \
        --out_path ${results}/${out_dir}/${lineage} 
        
    done
done


