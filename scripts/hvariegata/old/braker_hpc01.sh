#!/bin/bash

set -eu

basedir="/scratch/fkebaso/hippo/hvariegata_female"
results="${basedir}/results/braker/example"
genome="${basedir}results/BRAKER/example/genome.fa"
protein_file="${basedir}results/BRAKER/example/proteins.fa"
threads=48
email="fredrickkebaso@gmail.com"

# Set path to BRAKER Singularity container

export BRAKER_SIF="/scratch/fkebaso/hippo/hvariegata_female/braker/braker3.sif" 

# Check whether Singularity is installed
echo "Checking for Singularity..."
if ! command -v singularity &> /dev/null
then
    echo "Singularity could not be found."
    exit 1
fi

# Create new output directory
echo "Creating new output directory..."
mkdir -p "${results}"


# Run BRAKER using Singularity
echo "Running BRAKER..."

/usr/local/bin/singularity exec -B ${PWD}:${PWD} ${BRAKER_SIF} braker.pl \
--genome="${genome}" \
--prot_seq="${protein_file}" \
--threads "${threads}" \
--workingdir="${results}" \
--softmasking \
--min_contig=300 \
--gm_max_intergenic 10000 \
--skipOptimize \
--makehub \
--gff3 \
--email "${email}" 
