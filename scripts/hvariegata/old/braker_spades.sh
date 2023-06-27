#!/bin/bash
#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results_old/braker/velvet/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hcamelina_male/results_old/braker/velvet/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_velvet_hc_m

# ---------------- braker Gene Prediction ----------------

# Ab inition gene prediction

# ----------------Modules------------------

# Load Singularity module

module load chpc/singularity/3.5.3

# Create output variables
echo "Creating output variables..."
basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_male"
results="${basedir}/results_old/braker/velvet"
genome="${basedir}/results_old/repeatmasker/velvet/hcamelina_m_velvet_genome_filtered_assembly_renamed.fasta.masked"
protein_file="/mnt/lustre/users/fkebaso/hippo/data/databases/close_sp_genome_databases/orthoDB/glossina_proteins.fa"
threads=56
min-contig=100
email="fredrickkebaso@gmail.com"

# Set path to BRAKER Singularity container
export BRAKER_SIF="/apps/chpc/bio/BRAKER-3.0.3/braker3.sif"

# Check whether Singularity is installed
echo "Checking for Singularity..."
if ! command -v singularity &> /dev/null
then
    echo "Singularity could not be found."
    exit 1
fi

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
# if [ -d ${results_old} ]; then
#     rm -r ${results_old}
# fi

# Create new output directory
echo "Creating new output directory..."
mkdir "${results}"

# Create empty output files for braker.out and braker.err
echo "Creating empty output files..."
touch "${results}/braker.err" "${results}/braker.out"

# ---------------- Run -----------------------

# Run BRAKER using Singularity
echo "Running BRAKER..."
singularity exec -B ${PWD}:${PWD} ${BRAKER_SIF} braker.pl \
--genome="${genome}" \
--prot_seq="${protein_file}" \
--threads "${threads}" \
--workingdir="${results}" \
--min_contig="{min-contig}" \
--augustus_args="--species=fly" \
--softmasking \
--gff3 \
--makehub \
--email "${email}" 

echo "BRAKER completed successfully !!!"

# -B ${PWD}:${PWD}: Bind-mount the current working directory inside the container
# ${BRAKER_SIF}: Path to the Singularity container to be used
# braker.pl: Name of the Braker script to be executed inside the container
# --genome="${genome}": Path to the genome FASTA file
# --prot_seq=$protein_file: Path to the protein sequence file
# --threads 48: Number of threads to be used
# --workingdir="${results}": Directory to store output files
# --min_contig=100: Minimum length of contigs to be considered
# --augustus_args="--species=fly": Additional arguments to be passed to the Augustus gene predictor
# --makehub: Create a UCSC genome browser hub for visualization
# --gff3: Generate output in GFF3 format
# --email "${email}": Email address to receive job notifications