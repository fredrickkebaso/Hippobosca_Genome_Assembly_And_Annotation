#!/bin/bash env

#Checks the quality of the reads using fastqc tool

for i in Data/*.gz

do

fastqc -o Results/quality_reports $i

done;