#!/bin/bash
#PBS -l select=5:ncpus=24:mpiprocs=24:mem=120gb
#PBS -q normal
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmasker/spades_raw/repeatmasker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/repeatmasker/spades_raw/repeatmasker.err
#PBS -m abe
#PBS -M "fredrickkebaso@gmail.com"
#PBS -N repeatmasker_spades

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
assembly_types=("velvet_raw" "spades_raw" "velvet_spades" "soapdenovo2" "velvet_pilon" "spades_pilon")
genome_files=(
     "${basedir}/velvet/velvet_raw/hv_f_velvet_raw_genome_filtered_assembly_renamed.fasta"
     "${basedir}/spades/hv_f_spades_genome_filtered_assembly_renamed.fasta"
     "${basedir}/velvet/spades_corrected/hv_f_velvet_spades_genome_filtered_assembly_renamed.fasta"
     "${basedir}/soapdenovo2/soapdenovo_raw_assembly/hv_f_soapdenovo2_genome_filtered_assembly_renamed.fasta"
     "${basedir}/pilon/velvet_hv_f_pilon_genome_filtered_assembly_renamed.fasta"
     "${basedir}/pilon/spades/hv_f_spades_genome_filtered_assembly_renamed_pilon.fasta"
 )


num_threads=20
output_dir="${basedir}/repeatmasker"

# Create log and error files
touch "${output_dir}/repeatmasker.out" "${output_dir}/repeatmasker.err"

# Run RepeatMasker to mask repeats in the assembled genome
echo "Masking repeats: Recommended, RepeatMasker version 4.1.5"
echo "Found $(RepeatMasker -v)"
echo "Proceeding with masking..."

for i in "${!assembly_types[@]}"; do
    assembly_type="${assembly_types[$i]}"
    file="${genome_files[$i]}"
    
    # Get the file name without the extension
    file_name="$(basename "${file%.*}")"
    
    # Create output directory based on assembly type
    assembly_output_dir="${output_dir}/${assembly_type}"
    mkdir -p "${assembly_output_dir}"
    
    # Run RepeatMasker with the appropriate options
    RepeatMasker \
    -pa "${num_threads}" \
    -e rmblast \
    -noisy \
    -dir "${assembly_output_dir}/${file_name}" \
    -a \
    -xsmall \
    -poly \
    -source \
    -species 'Drosophila melanogaster' \
    -gff \
    "${file}"
done





