#!/bin/bash
# /home/kebaso/Documents/projects/hippo/hvariegata_female/results/blast_homologs/spades/orthofinder/sensory_neuron_membrane_protein.fa
basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/blast_homologs/spades/orthofinder"
mafft --maxiterate 100 --thread -3 "${basedir}/sensory_neuron_membrane_protein.fa" > "${basedir}/SNMPS.align"