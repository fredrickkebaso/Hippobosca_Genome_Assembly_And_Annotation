#!/bin/bash 

# ---------------------- Modules ------------------------------

echo "Loading required modules/Activating required environment..."

env_name="kmergenie"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"

basedir="/mnt/lustre/users/fkebaso/hippo/hcamelina_m_f/results"
results="${basedir}/clean_reads"
#Determines kmer length
echo Determining Best Kmer length using KmerGenie v 1.7051

for file in `ls ${results}/*.fq.gz`
do
kmergenie  $file --diploid -k 141 -t 24 -o ${results}/kmer-genie
done;

