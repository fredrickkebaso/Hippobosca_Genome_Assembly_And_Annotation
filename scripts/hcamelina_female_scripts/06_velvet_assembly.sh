#!/bin/bash

#Assembles the reads to generate a consensus sequence

set -eu

#Running velvet
module load velvet

mkdir -p results/velvet_out

echo Assembling Hcamelina_female_genome using velvet. Recommended Version 1.2.10.

velveth results/velvet_out 41 \
-fastq.gz -shortPaired \
-separate \
results/clean_reads/S3-Hcamelina-F.R1_val_1.fq.gz \
results/clean_reads/S3-Hcamelina-F.R2_val_2.fq.gz && \
velvetg results/velvet_out/ \
-exp_cov auto \
-cov_cutoff auto \
-ins_length 149 
# Remove intermediate files 

rm results/velvet_out/{Graph2,LastGraph,Log,PreGraph,Roadmaps,Sequences} 

#Rename the generated assembly, contigs.fa to match the organism,hcamelina

mv results/velvet_out/contigs.fa results/velvet_out/hcamelina_f_genome.fa 

#Rename the stats file to match the organism

mv results/velvet_out/stats.txt results/velvet_out/hcamelina_f_genome_stats.txt

echo Completed assembling hcamellina_male genome with Velvet successfully !!!!







