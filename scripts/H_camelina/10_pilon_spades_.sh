#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00           
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/pilon/spades/pilon.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/pilon/spades/pilon.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N pilon_spades_hc_f

echo "Activating conda env and checking if it exists first..."

env_name="pilon"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

echo "Environment '$env_name' activated."

# Improving draft assemblies (Single base differences, Small indels,
# Larger indel or block substitution events, Gap filling, Identification
# of local misassemblies, including optional opening of new gap)

# Set the work directory
basedir="/scratch/fkebaso/hippo/hcamelina_male/results"
genome="${basedir}/spades/hcamelina_m_spades_genome_filtered_assembly_renamed.fa"
bam_file="${basedir}/mapping/hcamelina_m_spades_genome_filtered_assembly_renamed_mapped.sorted.bam"
out_prefix=$(basename $genome .fa)
results="${basedir}/pilon/spades" 
jar_file="/home/fkebaso/.conda/envs/pilon/share/pilon-1.24-0/pilon.jar"

echo "Creating the directory for the Pilon output files..."

mkdir -p "${results}"

touch "${results}/pilon.err" "${results}/pilon.out"

echo "Running Pilon with the specified parameters..."

java -Xmx150g -jar ${jar_file} \
--genome "${genome}" \
--frags "${bam_file}" \
--fix "bases" \
--changes \
--tracks \
--diploid \
--K 51 \
--output $(basename $genome .fa) \
--outdir "${results}"

echo "Pilon has finished running."

# Parameter explanations:
# --genome: The path to the input genome assembly file in FASTA format.
# --frags: The path to the input read alignment file in BAM format.
# --outdir: The path to the output directory where the Pilon output files will be written.
# --changes: Generate a file of changes made to the original genome assembly.
# --tracks: Generate a file of all changes made to the genome, including those rejected.
# --diploid: Set the organism ploidy to \diploid.
# --K: The k-mer length used in the assembly process. In this case, a value of 51 is used.


