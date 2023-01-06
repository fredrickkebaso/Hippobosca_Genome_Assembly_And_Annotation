#!/bin/bash

set -eu

#For assessment of genome quality and completeness
mkdir -p results/busco_stats/{hvariegata_f_genome_stats,hlongipennis_f_genome_stats,hcamelina_f_genome_stats,hcamelina_m_genome_stats}

echo Computing hvariegata_f_genome_stats...

busco --in results/velvet_out/hvariegata_female_genome/contigs.fa --lineage diptera_odb10 --out genome_stats --out_path results/busco_stats/hvariegata_f_genome_stats \
--mode genome --augustus --cpu 8 --download_path results/busco_stats/hvariegata_f_genome_stats --force --scaffold_composition --update-data

echo Done

echo Computing hlongipennis_f_genome_stats...

busco --in results/velvet_out/hlongipennis_female_genome/contigs.fa --lineage results/busco_stats/lineages/diptera_odb10 --out genome_stats --out_path results/busco_stats/hlongipennis_f_genome_stats \
--mode genome --augustus --cpu 8 --download_path results/busco_stats/hlongipennis_f_genome_stats --force --scaffold_composition --update-data

echo Done
echo Computing hcamelina_f_genome_stats...

busco --in results/velvet_out/hcamelina_female_genome/contigs.fa --lineage results/busco_stats/lineages/diptera_odb10 --out genome_stats --out_path results/busco_stats/hcamelina_f_genome_stats \
--mode genome --augustus --cpu 8 --download_path results/busco_stats/hcamelina_f_genome_stats --force --scaffold_composition --update-data

echo Done
echo Computing hcamelina_m_genome_stats...

busco --in results/velvet_out/hcamelina_male_genome/contigs.fa --lineage results/busco_stats/lineages/diptera_odb10 --out genome_stats --out_path results/busco_stats/hcamelina_m_genome_stats \
--mode genome --augustus --cpu 8 --download_path results/busco_stats/hcamelina_m_genome_stats --force --scaffold_composition --update-data
echo Done

echo Completed BUSCO metrics computation successfully !!!
