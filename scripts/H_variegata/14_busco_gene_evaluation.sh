#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:mem=400gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results_old/busco/gene_quality/spades/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results_old/busco/gene_quality/spades/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N busco_gene_quality

set -eu

echo "Loading required modules/Activating required environment..."

env_name="busco"

source /home/fkebaso/miniconda3/bin/activate /home/fkebaso/miniconda3/envs/mamba/envs/${env_name}

echo "Conda environment activated!"

#Initalizing variables

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results="${basedir}/results_old/busco/gene_quality/spades_piloned"
predicted_genes=("${basedir}/results_old/braker/spades_piloned/hvariegata_female_spades_piloned.aa")
lineages=("metazoa_odb10"
          "arthropoda_odb10"
          "insecta_odb10"
          "diptera_odb10")

echo "Loading required modules/Activating required environment..."

#Activate mamba environment embedded in conda. within it is the busco mamba environment, activate that too and run busco


echo "Running Busco gene evaluation..."

# Download lineages
for genome in "${predicted_genes[@]}"; do
    out_dir=$(basename "${genome}" .aa)
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
        busco --in "${genome}" \
        --lineage "${lineage}" \
        --out "${lineage}_stats" \
        --mode prot --cpu 24 \
        --datasets_version odb10 \
        --download_path ${results}/${out_dir} \
        --out_path ${results}/${out_dir}/${lineage} \
        --update-data 
    done
done

#--evalue 0.001 --species "fly" \
#--download_path "${results}/${out_dir}"
# --download_path "${results}/${out_dir}" \
#         --scaffold_composition \
#         --update-data
#--out_path "${results}/${out_dir}" 
#NAME - name to use for the run and temporary files 
#GENE_SET gene set protein sequence file in fasta format 
#LINEAGE path to the lineage to be used (-l /path/to/lineage)
# --out_path OUTPUT_PATH  Optional location for results folder, excluding results folder name. Default is current working directory.
# --force           Force rewriting of existing files. Must be used when output files with the provided name already exist.
#--download_path DOWNLOAD_PATH Specify local filepath for storing BUSCO dataset downloads
#  -c N, --cpu N         Specify the number (N=integer) of threads/cores to use.