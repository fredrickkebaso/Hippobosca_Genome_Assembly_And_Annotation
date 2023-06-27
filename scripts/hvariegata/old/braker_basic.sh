#!/bin/bash
#PBS -l select=2:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=18:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker_basic/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker_basic/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_basic_hv_f

# ---------------- braker_basic Gene Prediction ----------------

# Ab inition gene prediction

# ---------------- Requirements ------------------

echo "Creating output variables..."

orthoDB="/mnt/lustre/users/fkebaso/hippo/data/databases/close_sp_genome_databases/orthoDB"
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results_dir="${basedir}/results/braker_basic"
email="fredrickkebaso@gmail.com"

mkdir -p "${results_dir}"
touch "${results_dir}/braker.err" "${results_dir}/braker.out"

genome="${basedir}/results/repeatmasker/hvariegata_f_genome.fa.masked"
protein_file="${orthoDB}/Arthropoda.fa"

# ---------------- Modules -----------------------

module load chpc/singularity/3.5.3
module add chpc/singularity/3.5.3

# env_name="braker"
# if ! conda info --envs | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi

# source "$(conda info --base)/etc/profile.d/conda.sh"
# conda activate "$env_name"

# ---------------- Run -----------------------

# echo "Braker version: $(braker.pl --version)"

echo "Using singularity container"

echo "Running braker..."

cd /mnt/lustre/users/fkebaso/hippo/genome_utility_tools/

singularity exec braker3.sif braker.pl \
--genome="${genome}" \
--prot_seq="${protein_file}" \
--workingdir="${basedir}/results/braker_basic" \
--threads 30 \
--makehub \
--email "${email}"
echo "Braker completed successfully !!!"

# --genome=:input genome assembly file to be used for gene prediction
# --prot_seq=input protein sequences file for evidence-based gene prediction
# --AUGUSTUS_ab_initio: enables gene prediction using the ab initio gene predictor AUGUSTUS
# --augustus_args="--species=fly": provides arguments to the AUGUSTUS gene predictor, specifying the species as "fly"
# --useexisting: enables the use of existing gene prediction files from a previous run of braker.pl
# --workingdir=specifies the output directory where results will be saved
# --threads 50: specifies the number of threads to be used for the gene prediction process
# --makehub: generates a UCSC Genome Browser hub to visualize the gene predictions and annotation results
# --email "${email}": specifies an email address to which notifications will be sent after the completion of the job
# --checksoftware: checks that all required software and dependencies are available on the system before running braker.pl.

