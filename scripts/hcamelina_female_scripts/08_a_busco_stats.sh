#!/bin/bash

set -eu

#For assessment of genome quality and completeness using 

mkdir -p results/{busco_stats,busco_plots}

echo Computing hcamelina_f_genome_stats using BUSCO. Recommended version 5.4.4....

echo Found `busco --version` proceeding with metric computation...

busco \
--in results/repeatmasker/hcamelina_f_genome.fa.masked \
--lineage arthropoda_odb10 \
--out genome_stats \
--out_path results/busco_stats \
--mode genome \
--augustus \
--cpu 12 \
--download_path results/busco_stats \
--scaffold_composition \
--update-data

#copy and rename (match organism) the summary report to busco plot dir

cp results/busco_stats/genome_stats/short_summary.specific.arthropoda_odb10.genome_stats.txt results/busco_plots/hcamelina_f_genome

echo Done

echo Completed BUSCO metrics computation successfully !!!

#Here is a breakdown of each flag used in the command:

#--in  input file for BUSCO analysis.

#--lineage arthropoda_odb10: Specifies the lineage dataset to be used for BUSCO analysis, which in this case is the arthropod ortholog database (ODB10).

#--out genome_stats: Specifies the name of the output file for the BUSCO analysis results.

#--out_path results/busco_stats: Specifies the output directory where the BUSCO analysis results will be stored.

#--mode genome: Specifies the mode of BUSCO analysis to be performed, which in this case is a genome mode analysis.

#--augustus: Specifies the use of AUGUSTUS for gene prediction during the BUSCO analysis.

#--cpu : Specifies the number of CPUs to be used for the BUSCO analysis.

