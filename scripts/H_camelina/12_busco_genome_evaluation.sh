#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:mem=400gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/busco/genome_quality/genome.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/busco/genome_quality/genome.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N busco_genome_quality

set -eu

#Basedirectory

basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results"

#Rename the input files
cp "${basedir}/repeatmasker/velvet/hcamelina_m_velvet_genome_filtered_assembly_renamed.fa.masked" \
   "${basedir}/repeatmasker/velvet/hcamelina_m_velvet_genome.fa"

#Initalizing variables
results="${basedir}/busco/genome_quality"
genomes=("${basedir}/repeatmasker/velvet/hcamelina_m_velvet_genome.fa")
mode="genome"
threads=24
lineages=("metazoa_odb10"
          "arthropoda_odb10"
          "insecta_odb10"
          "diptera_odb10")

echo "Loading required modules/Activating required environment..."

env_name="busco"

source /home/fkebaso/miniconda3/bin/activate /home/fkebaso/miniconda3/envs/mamba/envs/${env_name}

echo "Conda environment activated!"

echo "Running Busco gene evaluation..."

# Download lineages
for genome in "${genomes[@]}"; do
    out_dir=$(basename "${genome}" .fa)
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
        busco --in "${genome}" \
        --lineage "${lineage}" \
        --augustus \
        --augustus_species "fly" \
        --force \
        --out "${lineage}_stats" \
        --mode ${mode} --cpu "${threads}" \
        --datasets_version odb10 \
        --download_path ${results}/${out_dir} \
        --out_path ${results}/${out_dir}/${lineage} \
        --update-data      
    done
done

