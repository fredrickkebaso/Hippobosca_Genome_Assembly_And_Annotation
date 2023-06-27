#!/bin/bash
#PBS -l select=2:ncpus=24
#PBS -l walltime=48:00:00
#PBS -q serial
#PBS -P CBBI1470
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmasker/pilon/repeatmasker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmasker/pilon/repeatmasker.err
#PBS -m abe
#PBS -M "fredrickkebaso@gmail.com"
#PBS -N repeatmasker_pilon

echo "Loading required modules/Activating required environment..."

#module load chpc/BIOMODULES 
#module add RepeatMasker/4.1.5

env_name="repeatmasker"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Set input variables
basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
assembly_type="kraken"
assembly_file="${basedir}/velvet/${assembly_type}/hvariegata_f_velvet_kraken_genome.fa"
num_threads=60
output_dir="${basedir}/repeatmasker/${assembly_type}"

# Create output directory
mkdir -p ${output_dir}

# Create log and error files
touch ${basedir}/repeatmasker/${assembly_type}/repeatmasker.out ${basedir}/repeatmasker/${assembly_type}/repeatmasker.err

# Run RepeatMasker to mask repeats in the assembled genome
echo "Masking repeats: Recommended, RepeatMasker version 4.1.5"
echo "Found `RepeatMasker -v`"
echo "Proceeding with masking..."

RepeatMasker \
-pa ${num_threads} \
-e rmblast \
-noisy \
-dir ${output_dir} \
-a \
-xsmal \
-poly \
-source \
-species 'Drosophila melanogaster' \
-gff \
${assembly_file}

