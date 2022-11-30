#!/bin/bash env

#Checks the quality of the reads using fastqc tool version 0.11.9


mkdir -p ${PWD}/results/quality_reports

for i in Data/*.gz

do

fastqc -o ${PWD}/results/quality_reports 

done;

#General Report using Multiqc version 1.9

mkdir -p ${PWD}/results/multiqc_report

multiqc -o ${PWD}/results/multiqc_report ${PWD}/results/quality_reports
