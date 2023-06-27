#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:mem=400gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/manase/assembly/results/spades/spades.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/manase/assembly/results/spades/spades.err
#PBS -m abe
#PBS -M aloomanase@gmail.com
#PBS -N spades_MB

#Assembles shortreads using SPADES Assembler

echo Loading required modules...

module load chpc/BIOMODULES
module add SPAdes/3.15.4

#Activating conda environment

# env_name="spades"
# if ! conda info --envs | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi

# source "$(conda info --base)/etc/profile.d/conda.sh"
# conda activate "$env_name"

echo Initialising variables...

basedir="/mnt/lustre/users/fkebaso/hippo/manase/assembly"
reads="/mnt/lustre/users/fkebaso/hippo/manase/raw-reads"
forward_read="${basedir}/arabiensis/mapping/umapped_Pool_J4-LB_1.fq.gz"
reverse_read="${basedir}/arabiensis/mapping/umapped_Pool_J4-LB_2.fq.gz"
results="${basedir}/results/spades"

#Create output directory

mkdir -p ${basedir}/results/spades

touch "${results}/spades.out" "${results}/spades.err"

#Run spades

spades.py -o "${results}" -1 "${forward_read}" -2 "${reverse_read}" --threads 40 --memory 400 -k 41,47,51 --cov-cutoff auto 

