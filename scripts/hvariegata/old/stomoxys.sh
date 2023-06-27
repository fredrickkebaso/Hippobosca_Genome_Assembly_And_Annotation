#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40:mem=950gb
#PBS -P CBBI1470
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/pjepchirchir/stomoxys/results/spades-ec/corrected/spades-assmbl/spades.out
#PBS -e /mnt/lustre/users/pjepchirchir/stomoxys/results/spades-ec/corrected/spades-assmbl/spades.err
#PBS -m abe
#PBS -M parcelmaiyo@gmail.com
#PBS -N spades-assmbl

#Loading modules
module load chpc/BIOMODULES
module load SPAdes/3.15.4

#change directory
cd /mnt/lustre/users/pjepchirchir/stomoxys/results/spades-ec/corrected

#cd /mnt/lustre/users/pjepchirchir/stomoxys/results/spades
#make output directory
#mkdir ./spades-assmbl

#Running spades

spades.py -k 65 --threads 40 --memory 950 --careful \
-o ./spades-assmbl  -1 sindica-M-S1-R1_val_1.fq.00.0_0.cor.fastq.gz \
-2 sindica-M-S1-R2_val_2.fq.00.0_0.cor.fastq.gz --only-assembler

