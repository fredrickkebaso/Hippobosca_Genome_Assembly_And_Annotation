#!/bin/bash

set -eu

mkdir -p results/augustus_annotations

echo Predicting hcamelina_f_genome_genes using Augustus.Recommended Augustus V3.5.0

echo Found `augustus --version` Proceeding with annotation...

augustus \
--strand=both \
--uniqueGeneId=true \
--UTR=on \
--cpu=12 \
--gff3=on \
--alternatives-from-sampling=true \
--outfile=results/augustus_annotations/hcamelina_f_genome_ann.gff \
--species=fly \
results/repeatmasker/hcamelina_f_genome.fa.masked

echo Completed annotation successfully !!!

# --strand=both: predict genes on both strands of the DNA.

# --uniqueGeneId=true: generate unique IDs for each predicted gene.

# --UTR=on:predict untranslated regions (UTRs) in addition to coding regions.

# --gff3=on: output file format should be in GFF3 format, a standard file format for genomic annotations.

# --alternatives-from-sampling=true: use alternative splicing models to predict alternative isoforms of genes, based on a probabilistic model.

# --species=fly: This specifies the species for which the gene prediction parameters should be optimized. In this case, "fly" is used as a placeholder value, as no specific training set for hcamelina_m may be a$




