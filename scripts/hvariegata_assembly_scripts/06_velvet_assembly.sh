#!/bin/bash

set -eu

#Running velvet

mkdir -p results/velvet_out/hvariegata_female_genome

echo Assembling Hvariegata_female_genome using velvet. Recommended Version 1.2.10.

velveth results/velvet_out/hvariegata_female_genome 51 \
-fastq.gz -shortPaired \
-separate \
results/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz \
results/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz && \
velvetg results/velvet_out/hvariegata_female_genome \
-exp_cov auto \
-cov_cutoff auto \
-ins_length 149 

echo Completed assembling hvariegata genome with Velvet successfully !!!!







