#!/bin/bash
#maks repeats in the assembled genome 

echo Masking repeats using RepeatMasker version 4.1.2

mkdir -p results/repeatmasker/{hvariegata_f_genome_masked,hlongipennis_f_genome_masked,hcamelina_f_genome_masked,hcamelina_m_genome_masked}

RepeatMasker -e ncbi -noisy -dir results/repeatmasker/hvariegata_f_genome_masked -a -small -poly -source -gff results/velvet_out/hvariegata_female_genome/contigs.fa
#-e- search engine, -noisy-prints progress to the stdout, -a produces alignment file, -small-Returns complete .masked sequence in lower case
#-source-Includes for each annotation the HSP "evidence"., -gff-Creates an additional Gene Feature Finding format output


echo Done