#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:mem=400gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/busco/gene_quality/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/busco/gene_quality/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N busco_gene_quality

set -eu

#Initalizing variables

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results="${basedir}/results/busco/gene_quality/"
predicted_genes=("${basedir}/results/braker/spades/h_variegata_spades_genes.faa" "${basedir}/results/braker/velvet/h_variegata_velvet_genes.faa")
mode="prot"
lineages=("metazoa_odb10"
          "arthropoda_odb10"
          "insecta_odb10"
          "diptera_odb10")

echo "Loading required modules/Activating required environment..."

module load chpc/BIOMODULES
module add busco/5.4.5

echo Setting up required environment...

echo "Running Busco gene evaluation..."

# Download lineages
for genome in "${predicted_genes[@]}"; do
    out_dir=$(basename "${genome}" .faa)
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
        busco --in "${genome}" \
        --lineage "${lineage}" \
        --out "${lineage}_stats" \
        --mode ${mode} --cpu 40 \
        --datasets_version odb10 \
        --download_path ${results}/${out_dir} \
        --out_path ${results}/${out_dir}/${lineage} \
        --update-data 
    done
done


