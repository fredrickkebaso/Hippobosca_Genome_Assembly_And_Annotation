#!/bin/bash

#To compare completeness of different genome assemblies

#Collect all the busco summary reports to a single directory  

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female"

assembler="gene_quality"
seq="spades"

echo Plotting busco statistics...

python3 "${basedir}/scripts/generate_plot.py" --working_directory "${basedir}/results/busco/${assembler}/${seq}"

echo Plotting completed.

