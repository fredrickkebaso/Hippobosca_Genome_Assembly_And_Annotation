#!/bin/bash

#To compare completeness of different genome assemblies

echo Plotting busco statistics...

python \
scripts/generate_plot.py \
--working_directory \
results/busco_stats/hvariegata_f_genome_stats/busco_summarries

echo Plotting completed.