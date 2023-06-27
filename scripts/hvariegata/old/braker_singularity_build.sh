#!/bin/bash

#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/braker_singularity/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/braker_singularity/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_singularity_building

# Set the base directory where you want to build the container
basedir=/mnt/lustre/users/fkebaso/hippo/genome_utility_tools
results_dir="${basedir}/results/braker_singularity"
email="fredrickkebaso@gmail.com"

mkdir -p "${results_dir}"
touch "${results_dir}/braker.err" "${results_dir}/braker.out"

# Load Singularity module
module load chpc/singularity/3.5.3
module add chpc/singularity/3.5.3

# Change to the base directory
cd $basedir

# Build the Singularity container from the Braker3 Docker image
echo "Building Singularity container..."
singularity build braker3.sif docker://teambraker/braker3:latest

echo "Done building Singularity container!"
