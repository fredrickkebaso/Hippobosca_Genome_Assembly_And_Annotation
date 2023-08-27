#!/bin/bash                                                                                         
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/repeatmasker/spades/spades.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/repeatmasker/spades/spades.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N Repmode&masker

set -eu

#Constructs de novo repeat library and uses it to mask the genome

#-----------------------------Load modules---------------------------------

echo "Setting up the environment..."
echo Loading required modules..

# Check if the conda environment exists

env_name="repeatmodeler"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

echo Activate the conda environment

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# echo Loading required modules..

# module load chpc/BIOMODULES
# module add RepeatModeler/2.0.4


# Set the work directory
basedir="/scratch/fkebaso/hippo/hcamelina_male/results"
genome="${basedir}/pilon/spades/hcamelina_m_spades_genome_filtered_assembly_renamed.fa"
repeatmodeler_results="${basedir}/repeatmodeler/spades"
repeatmasker_results="${basedir}/repeatmasker/spades"
threads=64
# close_species="'Drosophila melanogaster'"

# Create the output directory
mkdir -p "${repeatmodeler_results}"
mkdir -p "${repeatmasker_results}"

# Build the database name from the genome file

db_name=$(basename "$genome" .fa)

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

#Step 1: Building a RepeatModeler database

#BuildDatabase:build a RepeatModeler database,
#-name :specifies the name of the RepeatModeler database to be created.
#-engine rmblast: This option specifies the search engine to be used by RepeatModeler for identifying repeat elements.
#results/velvet_out/hlongipennis_f_genome: input file for building the RepeatModeler database.

#Step 2: Running RepeatModeler
#RepeatModeler:  RepeatModeler to identify repeat elements and build a library of their consensus sequences.
#-database specifies the name of the RepeatModeler database created in Step 1.
#-pa 42: specifies the number of processors to be used by RepeatModeler during the analysis.
#-LTRStruct: This option tells RepeatModeler to perform a search for LTR retrotransposons, which are a type of repetitive element that includes long terminal$

#-------Repeatmasker--------

#-pa-(rallel) [number],The number of sequence batch jobs [50kb minimum] to run in parallel.RepeatMasker will fork off this number of parallel jobs, each running the search engine specified.
#-e- search engine, RepeatMasker-specific version of the NCBI BLAST search engine.It is a fast and sensitive tool for detecting repeated elements by aligning them to a repeat database.
#-noisy-prints progress to the stdout,
#-a produces alignment file,
#-small-Returns complete .masked sequence in lower case
#-source-Includes for each annotation the HSP "evidence".,
#-gff-Creates an additional Gene Feature Finding format output
