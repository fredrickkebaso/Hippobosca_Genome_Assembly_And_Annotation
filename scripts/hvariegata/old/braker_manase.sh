#!/bin/bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=48:00:00
#PBS -P CBBI1470
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/manase/braker.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/braker/manase/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_manase_basic_hv_f

# ---------------- braker Gene Prediction ----------------

# Ab inition gene prediction

# ----------------Modules------------------

# Load Singularity module
module load chpc/singularity/3.5.3

# Create output variables
echo "Creating output variables..."

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
results="${basedir}/results/braker/manase/braker"
genome="${basedir}/results/braker/manase/MB_draft.fasta"
protein_file="${basedir}/results/braker/manase/Fungi.fa"
threads=48
email="aloomanase@gmail.com"

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
if [ -d ${results} ]; then
    rm -r ${results}
fi

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
--min_contig=300 \
--makehub \
--gff3 \
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