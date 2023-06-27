#!/bin/bash

#PBS -l select=1:ncpus=56:mpiprocs=56:mem=950gb:nodetype=haswell_fat
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/manase/assembly/results/abyss/abyss.out 
#PBS -e /mnt/lustre/users/fkebaso/hippo/manase/assembly/results//abyss/abyss.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N abyss_hv_f

echo Loading required modules...

# module load chpc/BIOMODULES
# module load ABySS/2.1.5

env_name="abyss-env"
if ! conda info --envs | grep -q "^$env_name"; then
    echo "Error: the environment '$env_name' does not exist."
    exit 1
fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$env_name"



echo Initializing variables...

basedir="/mnt/lustre/users/fkebaso/hippo/manase/assembly"
results="${basedir}/results/abyss"
memory=60G
jobs=24
kmer=41

# Raw reads
forward_read="${basedir}/arabiensis/mapping/poolB1.fq"
reverse_read="${basedir}/arabiensis/mapping/poolB2.fq"

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi


echo Creating output variables...

mkdir -p "${results}"
touch "${results}/abyss_.out" "${results}/abyss_.out"

echo Running AByss...

abyss-pe name=MB k="${kmer}" B="${memory}" --jobs="${jobs}" in="${forward_read} ${reverse_read}" --directory="${results}"


#abyss-pe name=MB k="${kmer}" B="${memory}" --jobs="${jobs}" lib='pe' in='${forward_read} ${reverse_read}' --directory="${results}"


#--directory parameter- out put directory

#--jobs parameter specifies the maximum number of parallel jobs that can be run at once.
# B=500 maximum memory usage is limited to 500G.
# --dry-run option will only simulate the assembly process and output the commands that would be run,but will not actually execute them.



