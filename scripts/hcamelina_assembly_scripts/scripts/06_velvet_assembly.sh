#!/bin/bash

#Assembles the reads to generate a consensus sequence

set -eu

#Running velvet
module load velvet

mkdir -p results/velvet_out/Hcamelina_male_genome

echo Assembling Hcamelina_male_genome using velvet. Recommended Version 1.2.10.

velveth results/velvet_out/Hcamelina_male_genome 51 \
-fastq.gz -shortPaired \
-separate \
results/clean_reads/S4-Hcamelina-M2.R1_val_1.fq.gz \
results/clean_reads/S4-Hcamelina-M2.R2_val_2.fq.gz && \
velvetg results/velvet_out/Hcamelina_male_genome \
-exp_cov auto \
-cov_cutoff auto \
-ins_length 149 

echo Completed assembling hcamellina_male genome with Velvet successfully !!!!







