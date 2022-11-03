#!/bin/bash env

#Checks the quality of the reads using fastqc tool version 0.11.9


mkdir -p ${PWD}/Results/quality_reports

for i in Data/*.gz

do

fastqc -o ${PWD}/Results/quality_reports 

done;

#General Report using Multiqc version 1.9

mkdir -p ${PWD}/Results/multiqc_report

multiqc -o ${PWD}/Results/multiqc_report ${PWD}/Results/quality_reports
