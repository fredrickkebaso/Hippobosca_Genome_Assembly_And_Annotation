#!/bin/bash

#PBS -l select=6:ncpus=24:mpiprocs=24:mem=120gb:nodetype=haswell_reg
#PBS -q normal
#PBS -l walltime=10:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/augustus_annotations/parallel_augustus.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/augustus_annotations/parallel_augustus.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N parallel_augustus
ulimit -s unlimited

#echo Loading required modules...

#echo Activating conda s environment...

#echo Initializing variables...

echo Creating output variables...

touch $basedir/augustus_annotations/parallel_augustus.out $basedir/augustus_annotations/parallel_augustus.err

#runs augustus in parallel, refer to https://github.com/eanbit-rt/augustus_parallel

#env_name="cgat-env"
#if ! conda info --envs | grep -q "^$env_name"; then
#    echo "Error: the environment '$env_name' does not exist."
#    exit 1
#fi

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate

workdir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"

mkdir -p ${workdir}/results/augustus_annotations

echo Predicting genes. Recommended Augustus V3.5.0

echo Found `augustus --version` Proceeding with annotation...

echo There are `grep -E '^>' ${workdir}/results/repeatmasker/hvariegata_f_genome.fa.masked | wc -l ` contigs.

echo Running augustus in parallel...

run_augustus_parallel \
-f ${workdir}/results/repeatmasker/hvariegata_f_genome.fa.masked \
-j 72 \
-c 120 \
-s aug_parallel \
-p '--strand=both --UTR=on --gff3=on --outfile=${workdir}/results/augustus_annotations/hvariegata_f_genome_ann.gff --species=fly --progress=true' \
-o ${workdir}/results/augustus_annotations


# -f Path to fasta file.fa (mandatory)
# -j N chunks of sequences (sequences will be equally distributed)
# -c Number of CPU cores to use (be careful with memory consumption of AUGUSTUS)
# -s Suffix (defaulting to Aug_parallel)
# -p AUGUSTUS parameters: e.g. '--species=arabidopsis,--UTR=on,--progress=true'
# -o Output path (full): /home/user/analysis
