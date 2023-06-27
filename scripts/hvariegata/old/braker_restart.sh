#!/bin/bash

#PBS -l select=1:ncpus=35:mpiprocs=35:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/braker_restart/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/braker_restart/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_restart_hv_f

# ---------------- Braker Gene Prediction ----------------

# Ab initio gene prediction

# ---------------- Requirements ------------------

echo "Loading required modules/Activating required environment..."

env_name="braker"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

echo "Creating output variables..."

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results_dir="${basedir}/results/braker"
restart_dir="${results_dir}/braker_restart"
genome="${basedir}/results/repeatmasker/hvariegata_f_genome.fa.masked"

# Creating the restart directory if it does not exist

mkdir -p "${restart_dir}"

# Creating empty error and output files if they do not exist

touch "${restart_dir}/braker.err" "${restart_dir}/braker.out"

# Running Braker with genome, hints, and threads options

echo "Starting Braker..."

braker.pl --genome="${genome}" --hints="${results_dir}/hintsfile.gff" \
--threads 30 --softmasking --species "hvariegata_female" \
--workingdir="${restart_dir}" --logfile "${restart_dir}/braker.log" \
2> "${restart_dir}/braker.err" | tee "${restart_dir}/braker.out"

echo "Braker run finished."
