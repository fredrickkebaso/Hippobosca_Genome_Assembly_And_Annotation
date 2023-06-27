#!/bin/bash

echo Initializing variables...

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"
spades_assembly="${basedir}/results/spades/scaffolds.fasta"
velvet_assembly="${basedir}/results/velvet/spades_corrected/hvariegata_f_spades_genome.fa"
soapdenovo_assembly="${basedir}/results/soapdenovo2/soapdenovo_raw_assembly/hv_f.scafSeq.fa"
results_dir="${basedir}/results/quickmerge"

mkdir -p "${results_dir}"

echo Activating required environment...

env_name="quickmerge"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

echo Running quick merge

# merge_wrapper.py "${spades_assembly}" "${velvet_assembly}" -prefix "${results_dir}/quickmerged"


echo Aligning the assmblies using nucmer...

 nucmer -l 100 -prefix "${results_dir}/quickmerged/nucmer" "${spades_assembly}" "${velvet_assembly}" -prefix "${results_dir}/quickmerged"

echo Done



echo Merging the assemblies...