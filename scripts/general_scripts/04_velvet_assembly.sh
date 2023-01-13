#!/bin/bash

set -eu

#Running velvet

mkdir -p results/velvet_out/{hvariegata_female_genome,hlongipennis_female_genome,hcamelina_female_genome,hcamelina_male_genome}

echo Running velvet...

echo Assembling Hvariegata_female_genome...

velveth results/velvet_out/hvariegata_female_genome 51 -fastq.gz -shortPaired -separate results/clean_reads/S1-Hvariegata-F.R1_val_1.fq.gz results/clean_reads/S1-Hvariegata-F.R2_val_2.fq.gz && \
velvetg results/velvet_out/hvariegata_female_genome -exp_cov auto -cov_cutoff auto -ins_length 139 -max_gap_count 4 

echo Assembling Hlongipennis_female_genome...

velveth results/velvet_out/hlongipennis_female_genome 51 -fastq.gz -shortPaired -separate results/clean_reads/S2-Hlongipenis-F.R1_val_1.fq.gz results/clean_reads/S2-Hlongipenis-F.R2_val_2.fq.gz && \
velvetg results/velvet_out/hlongipennis_female_genome -exp_cov auto -cov_cutoff auto -ins_length 139 -max_gap_count 4 

echo Assembling hcamelina_female_genome...

velveth results/velvet_out/hcamelina_female_genome 51 -fastq.gz -shortPaired -separate results/clean_reads/S3-Hcamelina-F.R1_val_1.fq.gz results/clean_reads/S3-Hcamelina-F.R2_val_2.fq.gz && \
velvetg results/velvet_out/hcamelina_female_genome -exp_cov auto -cov_cutoff auto -ins_length 139 -max_gap_count 4 

echo Assembling hcamelina_male_genome...

velveth results/velvet_out/hcamelina_male_genome 51 -fastq.gz -shortPaired -separate results/clean_reads/S4-Hcamelina-M.R1_val_1.fq.gz results/clean_reads/S4-Hcamelina-M.R2_val_2.fq.gz && \
velvetg results/velvet_out/hcamelina_male_genome -exp_cov auto -cov_cutoff auto -ins_length 139 -max_gap_count 4 

echo Completed assembling all genomes with Velvet successfully !!!!







