#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=900gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /home/alaigong/lustre/fkebaso/hippo/hcamelina_male/results/orthofinder/spades/orthofinder.out
#PBS -e /home/alaigong/lustre/fkebaso/hippo/hcamelina_male/results/orthofinder/spades/orthofinder.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N orthofinder_hv_f

set -eu

# ----------------------Orthofinder------------------------

#  Gene clustering

# ---------------- Requirements ------------------

echo "Initilizing variables..."
basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/orthofinder"
prot_sequences="${basedir}/proteindb"
results="${basedir}/spades"
error_files="${basedir}"

# Remove output directory if it already exists


echo Creating required directories...

mkdir -p ${error_files}

touch "${error_files}/orthofinder.err" "${error_files}/orthofinder.out"

# ---------------- Modules -----------------------

echo "Loading required modules/Activating required environment..."

env_name="orthofinder"

source /home/fkebaso/miniconda3/bin/activate /home/fkebaso/miniconda3/envs/${env_name}

echo "Conda environment activated!"


echo Finding orthologs... 

#OrthoFinder script for fast, accurate and comprehensive for performing comparative genomics

orthofinder -M msa -f "${prot_sequences}" -t 56 -y -a 56 -S blast -o "${results}"

echo OrthoFinder Completed successfully !!! 


# OrthoFinder is a fast, accurate and comprehensive platform for comparative genomics. 
#It finds orthogroups and orthologs, infers rooted gene trees for all orthogroups and identifies all 
#of the gene duplication events in those gene trees. It also infers a rooted species tree for the species
# being analysed and maps the gene duplication events from the gene trees to branches in the species tree.
# OrthoFinder also provides comprehensive statistics for comparative genomic analyses. 
