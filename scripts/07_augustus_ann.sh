#!/bin/bash

set -eu

mkdir -p results/augustus_annotations

echo Predicting hvariegata_f_genome_genes...

augustus --strand=both --uniqueGeneId=true --UTR=on --gff3=on --alternatives-from-sampling=true --outfile=results/augustus_annotations/hvariegata_f_genome_ann.gff --species=fly results/velvet_out/hvariegata_female_genome/contigs.fa

echo Done

echo Predicting hlongipennis_f_genome_genes...

augustus --strand=both --uniqueGeneId=true --UTR=on --gff3=on --alternatives-from-sampling=true --outfile=results/augustus_annotations/hlongipennis_f_genome_ann.gff --species=fly results/velvet_out/hlongipennis_female_genome/contigs.fa

echo Done

echo Predicting hcamelina_f_genome_genes...

augustus --strand=both --uniqueGeneId=true --UTR=on --gff3=on --alternatives-from-sampling=true --outfile=results/augustus_annotations/hcamelina_f_genome_ann.gff --species=fly results/velvet_out/hcamelina_female_genome/contigs.fa

echo Done

echo prediction hcamelina_m_genome_genes...

augustus --strand=both --uniqueGeneId=true --UTR=on --gff3=on --alternatives-from-sampling=true --outfile=results/augustus_annotations/hcamelina_m_genome_ann.gff --species=fly results/velvet_out/hcamelina_male_genome/contigs.fa

echo Done 
