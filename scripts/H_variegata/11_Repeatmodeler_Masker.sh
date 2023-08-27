#!/usr/bin/env bash                                                                                         
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmodeler/velvet/velvet.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmodeler/velvet/velvet.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N Repmode&masker

#Constructs de novo repeat library and uses it to mask the genome

#-----------------------------Load modules---------------------------------

echo "Setting up the environment..."

echo Loading required modules Or activating the required conda environment...

echo Check if the conda environment exists
env_name="repeatmodeler"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

echo Activate the conda environment

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Set the work directory
basedir="/scratch/fkebaso/hippo/hvariegata_female/results"
genome="${basedir}/pilon/velvet/hvariegata_f_velvet_genome_filtered_assembly_renamed.fa"
repeatmodeler_results="${basedir}/repeatmodeler/velvet"
repeatmasker_results="${basedir}/repeatmasker/velvet"
threads=64
db_name=$(basename "$genome" .fa)

# Create the output directory
mkdir -p "${repeatmodeler_results}"
mkdir -p "${repeatmasker_results}"


# Print progress
echo "Building the RepeatModeler database..."

# Build the RepeatModeler database

BuildDatabase -name "${repeatmodeler_results}/${db_name}_db" -engine rmblast "$genome"

# Print progress

echo "Running RepeatModeler..."

# Run RepeatModeler to identify repeat elements and build the library

RepeatModeler -database "${repeatmodeler_results}/${db_name}_db" -pa "$threads" -LTRStruct

# Print completion message

echo "RepeatModeler analysis completed successfully."


echo Activating repeatmasker env...

env_name="repeatmasker"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

echo Masking repeats in the genome using repeatmasker

RepeatMasker -pa "${threads}" \
-lib "${repeatmodeler_results}/${db_name}_db-families.fa" \
-noisy -dir "${repeatmasker_results}" \
-a -xsmall -poly -source -gff "${genome}"

echo "Repeat masking completed successfully!"


