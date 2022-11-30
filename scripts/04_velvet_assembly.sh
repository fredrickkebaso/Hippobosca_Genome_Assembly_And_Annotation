#!/bin/bash

echo Concatenating reads

mkdir -p ${PWD}/results/{hvariegata_merged,velvet_out}

for f_read in ${PWD}/results/clean_reads/*S2*_val_1.fq.gz

do 
    RevRead=${f_read/_R1_001.fastq.gz/*_R2_002.fastq.gz}

    cat $f_read >> ${PWD}/results/hvariegata_merged/S2-hvariegata_merged_R1_.fq.gz
    cat $f_read >> ${PWD}/results/hvariegata_merged/S2-hvariegata_merged_R2_.fq.gz

done;
echo Concatenating reads Completed successfully !!!

echo Running velveth...Hashing...

module load velvet

velveth ${PWD}/results/velvet_out 21 -fastq.gz -shortPaired -separate ${PWD}/results/hvariegata_merged/S2-hvariegata_merged_R1_.fq.gz ${PWD}/results/hvariegata_merged/S2-hvariegata_merged_R2_.fq.gz 

 echo Completed hashing successfully
  
 echo Running velvetg !!!!
 
velvetg ${PWD}/results/velvet_out -exp_cov auto -cov_cutoff auto -ins_length 139 -read_trkg yes -amos_file yes  -max_gap_count 4 

echo Completed  Velvetg successfully !!!!


