#!/bin/bash 

#runs augustus in parallel, refer to https://github.com/eanbit-rt/augustus_parallel

 workdir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female"

mkdir -p ${workdir}/results/augustus_annotations

echo Predicting genes. Recommended Augustus V3.5.0

echo Found `augustus --version` Proceeding with annotation...

run_augustus_parallel \
    -f ${workdir}/results/repeatmasker/hvariegata_f_genome.fa.masked \
    -j 30 \
    -c 4 \
    -s aug_parallel \
    -p --strand=both --UTR=on --gff3=on --outfile=${workdir}/results/augustus_annotations/hvariegata_f_genome_ann.gff --species=fly \
    -o ${workdir}/results/augustus_annotations/

    

	# -f Path to fasta file.fa (mandatory)
	# -j N chunks of sequences (sequences will be equally distributed)
	# -c Number of CPU cores to use (be careful with memory consumption of AUGUSTUS)
	# -s Suffix (defaulting to Aug_parallel)
	# -p AUGUSTUS parameters: e.g. '--species=arabidopsis,--UTR=on,--progress=true'
	# -o Output path (full): /home/user/analysis






























#!/bin/bash

# set -eu

# echo Activating conda environment...

# env_name="hippo"
# if ! conda info --envs | grep -q "^$env_name"; then
#     echo "Error: the environment '$env_name' does not exist."
#     exit 1
# fi

# source "$(conda info --base)/etc/profile.d/conda.sh"
# conda activate "$env_name"

# echo Done


# # export LD_LIBRARY_PATH=/home/fkebaso/.conda/envs/busco/lib:$LD_LIBRARY_PATH
# # export LD_LIBRARY_PATH=/home/fkebaso/.conda/envs/busco/lib/:$LD_LIBRARY_PATH


# #Performs automated gene prediction

# workdir="/home/kebaso/Documents/projects/hippo/hvariegata_female"

# mkdir -p ${workdir}/results/augustus_annotations

# echo Predicting genes. Recommended Augustus V3.5.0

# echo Found `augustus --version` Proceeding with annotation...

# #/home/fkebaso/.conda/pkgs/augustus-3.5.0-pl5321hf46c7bb_1/bin/

# augustus \
# --strand=both \
# --uniqueGeneId=true \
# --UTR=on \
# --gff3=on \
# --outfile=${workdir}/results/augustus_annotations/hvariegata_f_genome_ann.gff \
# --species=fly \
# ${workdir}results/repeatmasker/hvariegata_f_genome.fa.masked

# echo Completed annotation successfully !!!

# # --strand=both: predict genes on both strands of the DNA.
# # --uniqueGeneId=true: generate unique IDs for each predicted gene.
# # --UTR=on:predict untranslated regions (UTRs) in addition to coding regions.
# # --gff3=on: output file format should be in GFF3 format, a standard file format for genomic annotations.
# # --alternatives-from-sampling=true: use alternative splicing models to predict alternative isoforms of genes, based on a probabilistic model.
# # --species=fly: This specifies the species for which the gene prediction parameters should be optimized. In this case, "fly" is used as a placeholder value, as no specific training set for hcamelina_m may be available.

