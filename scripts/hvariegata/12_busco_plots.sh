#!/bin/bash

#To compare completeness of different genome assemblies

echo Collecting summary files for the analyzed species. 


basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female"

assembler="velvet"
seq="gene"

#Rename the summary files

mv "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.arthropoda_odb10.gene_busco_stats.txt" "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.arthropoda_odb10.B_arthropoda_odb10_stats.txt"
mv "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.diptera_odb10.gene_busco_stats.txt" "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.diptera_odb10.D_diptera_odb10_stats.txt"
mv "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.insecta_odb10.gene_busco_stats.txt" "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.insecta_odb10.C_insecta_odb10_stats.txt"
mv "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.metazoa_odb10.gene_busco_stats.txt" "${basedir}/results/busco/${assembler}/${seq}/short_summary.specific.metazoa_odb10.A_metazoa_odb10_stats.txt"

echo Plotting busco statistics...

python3 "${basedir}/scripts/generate_plot.py" --working_directory "${basedir}/results/busco/${assembler}/${seq}"

echo Plotting completed.

