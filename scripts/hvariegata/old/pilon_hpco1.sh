#!/bin/bash
set -eu

echo Activating conda env and checking if it exists first

env_name="pilon"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"


#improving draft assemblies(Single base differences, Small indels,Larger indel or block substitution events,Gap filling,Identification of local misassemblies, including optional opening of new gap)

# Set the work directory
basedir="/scratch/fkebaso/hippo/hvariegata_female/results"
genome="${basedir}/spades/hv_f_spades_genome.fa"
bam_file="${basedir}/mappings/hv_f_spades_genome_mapped_reads.sorted.bam"
out_prefix=$(basename $genome .fa)
results="${basedir}/pilon/spades" 

# Create the directory for the Pilon output files

mkdir -p "${results}"

# Run Pilon with the specified parameters

java -Xmx200g -jar /home/fkebaso/.conda/envs/pilon/share/pilon-1.24-0/pilon.jar  \
--genome "${genome}" \
--frags "${bam_file} \
--fix "bases" \
--threads 60 \
--changes \
--tracks \
--diploid \
--K 51 \
--output $(basename $genome .fa) \
--outdir "${results}"
    

# Parameter explanations:
# --genome: The path to the input genome assembly file in FASTA format.
# --frags: The path to the input read alignment file in BAM format.
# --outdir: The path to the output directory where the Pilon output files will be written.
# --changes: Generate a file of changes made to the original genome assembly.
# --tracks: Generate a file of all changes made to the genome, including those rejected.
# --diploid: Set the organism ploidy to \diploid.
# --K: The k-mer length used in the assembly process. In this case, a value of 51 is used.


# #!/bin/bash

# #PBS -l select=10:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
# #PBS -q normal
# #PBS -l walltime=48:00:00
# #PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/pilon/pilon.out
# #PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/pilon/pilon.err
# #PBS -m abe
# #PBS -M fredrickkebaso@gmail.com
# #PBS -N pilon

# # Load required modules
# echo "Loading required modules..."

# # Activate conda environment
# echo "Activating conda soapdenovo environment..."
# env_name="pilon"
# if ! conda info --envs | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi

# source "$(conda info --base)/etc/profile.d/conda.sh"
# conda activate "$env_name"

# # Define the base directory
# basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"

# # Create the output directories
# output_dir="${basedir}/pilon"
# mkdir -p "${output_dir}/pilon_out"

# # Set the mapped reads file path
# reads_file="${basedir}/mappings/hv_f_genome_mapped_reads.bam"

# # Set the Pilon jar file path
# pilon_jar="/home/fkebaso/miniconda3/envs/pilon/share/pilon-1.24-0/pilon.jar"

# # Set the number of parallel jobs to use
# num_jobs=20

# # Create the error and output files
# touch "${output_dir}/pilon.err" "${output_dir}/pilon.out"

# Run Pilon in parallel using GNU Parallel
# echo "Running Pilon in parallel..."
# parallel --jobs "${num_jobs}" \
#          "java -Xmx60G -jar ${pilon_jar} --genome {} \
#          --frags ${reads_file} \
#          --outdir ${output_dir}/pilon_out/{/.} \
#          --changes --tracks --diploid --K 51" \
#          ::: "${basedir}/pilon/split_files/"fasta_split_*.fasta

# echo "Pilon has finished running on split fasta files."

# # Concatenate the final polished assembly for all the files into one
# echo "Concatenating the final polished assembly for all the files into one..."
# cat "${output_dir}/pilon_out/"*/*.fasta > "${output_dir}/final_pilon_polished_assembly.fa"
# echo "Done."


