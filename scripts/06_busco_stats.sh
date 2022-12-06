#!/bin/bash

#For assessment of genome quality and completeness

conda activate busco_env

busco \
--in /home/kebaso/Documents/projects/hippo/results/velvet_out/contigs.fa \
--lineage diptera_odb10 \
--out genome_stats \
--out_path /home/kebaso/Documents/projects/hippo/results/busco_stats/ \
--mode genome \
--augustus \
--cpu 2 \
--download_path /home/kebaso/Documents/projects/hippo/results/busco_stats/ \
--force \
--scaffold_composition \
--update-data
