#!/bin/bash

set -eu

#For assessment of genome quality and completeness using 
mkdir -p results/busco_stats

echo Computing hcamelina_f_genome_stats using BUSCO. Recommended version 5.4.4....

echo Found `busco --version` proceeding with metric computation...

busco \
--in results/repeatmasker/hcamelina_f_genome.fa.masked \
--lineage arthropoda_odb10 \
--out genome_stats \
--out_path results/busco_stats \
--mode genome \
--augustus \
--cpu 4 \
--download_path results/busco_stats \
--scaffold_composition \
--update-data

echo Done

echo Completed BUSCO metrics computation successfully !!!
