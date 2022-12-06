#!/bin/bash

set -eu

#Checks the quality of the reads using fastqc tool version 0.11.9

mkdir -p ${PWD}/results/{multiqc_report,quality_reports}

for i in ${PWD}/data/raw_reads/*S1*L001_R{1,2}_001.fastq.gz

do

fastqc -o ${PWD}/results/quality_reports $i

done;

#General Report using Multiqc version 1.9

multiqc -o ${PWD}/results/multiqc_report ${PWD}/results/quality_reports


echo CLEANING DATA USING TRIM_GALORE

#Trim_galore cleans reads and generates  a  fastqc report of the cleaned reads

mkdir -p  ${PWD}/results/quality_recheck

for f_read in ${PWD}/data/raw_reads/*S1*L001_R1_001.fastq.gz

do

revread=${f_read/_R1_/_R2_}

trim_galore \
-fastqc_args "--outdir ${PWD}/results/quality_recheck" \
--quality 35 \
--clip_R1 10 \
--clip_R2 10 \
--length 120 \
--cores 4 \
--phred33 \
--output_dir ${PWD}/results/clean_reads \
--paired ${f_read} ${revread}

done;

#Multiqc report

echo generating multiqc report of the cleaned reads

mkdir -p ${PWD}/results/quality_cleaned_reads/{multiqc_report,quality_recheck}

multiqc -o ${PWD}/results/quality_cleaned_reads/multiqc_report ${PWD}/results/quality_cleaned_reads/quality_recheck

echo Data cleaning completed !!!

echo Concatenating reads

mkdir -p ${PWD}/results/{hvariegata_merged,velvet_out}

for f_read in ${PWD}/results/clean_reads/*S1*L001_R1_001_val_1.fq.gz

do
    revread=${f_read/L001_R1_001_val_1.fq.gz/L001_R2_001_val_2.fq.gz}
    
    
    cat $f_read >> ${PWD}/results/hvariegata_merged/S1-hvariegata_merged_R1_.fq.gz

    cat $revread >> ${PWD}/results/hvariegata_merged/S1-hvariegata_merged_R2_.fq.gz

done;
echo Concatenating reads Completed successfully !!!

echo Running velveth...Hashing...


velveth ${PWD}/results/velvet_out 21 -fastq.gz -shortPaired -separate ${PWD}/results/hvariegata_merged/S1-hvariegata_merged_R1_.fq.gz ${PWD}/results/hvariegata_merged/S1-hvariegata_merged_R2_.fq.gz

 echo Completed hashing successfully
  
 echo Running velvetg !!!!
 
velvetg ${PWD}/results/velvet_out -exp_cov auto -cov_cutoff auto -ins_length 139 -read_trkg yes -amos_file yes  -max_gap_count 4 

echo Completed  Velvetg successfully !!!!


#For assessment of assembly quality
echo Generating assembled genome statistics using BUSCO and Augustus as the annotation tool

busco \
--in /home/kebaso/Documents/projects/hippo/results/velvet_out/contigs.fa \
--lineage diptera_odb10 \
--out genome_stats \
--out_path /home/kebaso/Documents/projects/hippo/results/busco_stats/ \
--mode genome \
--augustus \
--cpu 2 \
--download_path /home/kebaso/Documents/projects/hippo/results/busco_stats/ \
--force \
--scaffold_composition \
--update-data


Echo  Annotating the assembled genome using AUGUSTUS

echo To be loaded soon !!!......
