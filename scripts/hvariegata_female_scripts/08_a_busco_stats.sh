#!/bin/bash

set -eu

#For assessment of genome quality and completeness using 
mkdir -p results/busco_stats/hvariegata_f_genome_stats

echo Computing hvariegata_f_genome_stats using BUSCO. Recomended version 5.4.4....

echo Found `busco --version` proceeding to metric computation...

busco \
--in results/repeatmasker/hvariegata_f_genome_masked/contigs_30_50.fa.masked \
--lineage diptera_odb10 \
--out 30_50_genome_stats \
--out_path results/busco_stats/hvariegata_f_genome_stats \
--mode genome \
--augustus \
--cpu 4 \
--download_path results/busco_stats/hvariegata_f_genome_stats \
--scaffold_composition \
--update-data

echo Done

echo Completed BUSCO metrics computation successfully !!!
