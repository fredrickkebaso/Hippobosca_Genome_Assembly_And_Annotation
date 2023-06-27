#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:mem=400gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/hackathon/results/bbmap.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/hackathon/results/bbmap.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N bbmap
set -eu

module load chpc/BIOMODULES
module add bbmap/38.95

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/hackathon"
ref="${basedir}/GFUI18_006381.P9508.fasta"
reads_1="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz"
reads_2="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz"
results="${basedir}/results"

mkdir -p "${results}"

bbmap.sh ref="${ref}" in=${reads_1} in2=${reads_2} outm=${results}/mappings.sam bamscript=${basedir}/bamscript.sh &&

bash ${basedir}/bamscript.sh