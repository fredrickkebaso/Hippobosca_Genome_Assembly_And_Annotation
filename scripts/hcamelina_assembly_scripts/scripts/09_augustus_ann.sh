#!/bin/bash

set -eu

mkdir -p results/augustus_annotations

echo Predicting hcamelina_m_genome_genes using Augustus.Recommended Augustus V3.5.0

echo Found `augustus --version` Proceeding with annotation...

augustus \
--strand=both \
--uniqueGeneId=true \
--UTR=on \
--gff3=on \
--alternatives-from-sampling=true \
--outfile=results/augustus_annotations/hcamelina_m_genome_ann_25_25.gff \
--species=fly \
results/repeatmasker/hcamelina_m_genome_masked/contigs_25_25.fa.masked

echo Completed annotation successfully !!!
