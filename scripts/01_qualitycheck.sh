#!/bin/bash env

#Checks the quality of the reads using fastqc tool version 0.11.9


mkdir -p ${PWD}/results/{multiqc_report,quality_reports}

for i in ${PWD}/raw_reads/*.gz

do

fastqc -o ${PWD}/results/quality_reports $i

done;

#General Report using Multiqc version 1.9

multiqc -o ${PWD}/results/multiqc_report ${PWD}/results/quality_reports
