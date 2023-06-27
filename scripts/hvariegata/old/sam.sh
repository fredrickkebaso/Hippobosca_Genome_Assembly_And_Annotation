#!/usr/bin/env bash
#PBS -l select=3:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/sam/queued/LABEL_rsv_genotype_prediction_tool/rsvb.out
#PBS -e /mnt/lustre/users/fkebaso/sam/queued/LABEL_rsv_genotype_prediction_tool/rsvb.err
#PBS -m abe
#PBS -M samordil@gmail.com
#PBS -N rsvb

set -eu 

basedir="/mnt/lustre/users/fkebaso/sam/queued/LABEL_rsv_genotype_prediction_tool"

bash ${basedir}/rsvB_prediction.sh

echo Completed successfully!


