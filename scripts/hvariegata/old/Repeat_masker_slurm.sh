#!/bin/bash                                                                                         
#SBATCH --job-name=RepeatMasker     # Job name                             
#SBATCH --time=10:00:00                  # Walltime                                                  
#SBATCH --mem=100G
#SBATCH --ntasks=1                       # 1 tasks                                                   
#SBATCH --cpus-per-task=50                # number of cores per task                                 
#SBATCH --nodes=1                        # number of nodes                                           
#SBATCH --chdir=/scratch/fkebaso/hippo/hcamelina_male # From where you want the job to be run
#SBATCH --mail-type=ALL                #send email notifications to the user XX for all events (submission, start, finish, and failure)
#SBATCH --mail-user=fredrickkebaso@gmail.com       # set email address  
#SBATCH --output=/scratch/fkebaso/hippo/hcamelina_male/results/repeatmasker/spades/slurm_%x.out
#SBATCH --error=/scratch/fkebaso/hippo/hcamelina_male/results/repeatmasker/spades/slurm_%x.err

set -eu 

echo "Loading required modules/Activating required environment..."

env_name="repeatmasker"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

# Set input variables
basedir="/scratch/fkebaso/hippo/hcamelina_male/results"
assembly_type="velvet"
assembly_file="${basedir}/pilon/${assembly_type}/hcamelina_m_velvet_genome_filtered_assembly.fasta"
num_threads=50
results="${basedir}/repeatmasker/${assembly_type}"

# Remove output directory if it already exists
echo "Rename old output directory (if exists)..."
if [ -d ${results} ]; then
    mv ${results} ${results}_old
fi

# Create output directory
mkdir -p ${results}

# Run RepeatMasker to mask repeats in the assembled genome
echo "Masking repeats: Recommended, RepeatMasker version 4.1.5"
echo "Found `RepeatMasker -v`"
echo "Proceeding with masking..."

RepeatMasker -pa ${num_threads} -e rmblast -noisy -dir ${results} -a -xsmal -poly -source -species 'Drosophila melanogaster' -gff ${assembly_file}




