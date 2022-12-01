#!/bin/bash

#Assessing assembly quality for an assembled genome or reads

mkdir -p ${PWD}/results/quast_assembly_stats_drosophila
quast-lg.py  -o ${PWD}/results/quast_assembly_stats_drosophila \
-r ${PWD}/data/reference_genomes/drosophila/ncbi_dataset/data/GCF_000001215.4/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna \
-g ${PWD}/data/reference_genomes/drosophila/ncbi_dataset/data/GCF_000001215.4/genomic.gbff \
--threads 2 \
--eukaryote \
--circos \
--large \
--use-all-alignments \
--report-all-metrics \
--plots-format png \
--memory-efficient \
--gene-finding \
${PWD}/results/velvet_out/contigs.fa