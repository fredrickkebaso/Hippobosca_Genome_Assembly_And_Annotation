#!/bin/bash

set -eu 

basedir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_proteins_faa_copy/prot_genome_proteins_faa_filtered_ids/species"
gene_family=("odorant-binding receptor")

for pattern in "${gene_family}"; do
    output_file="${pattern// /_}.txt"  # Replace spaces with underscores in the pattern for the output file name
    output_path="$basedir/$output_file"
    echo "Gene Family: $pattern" > "$output_path"  # Create or overwrite the output file
    
    files=$(find "$basedir" -type f -name "*.fasta")
    
    for file in $files; do
        grep "^>" "$file" | grep -iE "$pattern" >> "$output_path" 
    done
done

count=$(grep -c "$pattern"  "$output_path")

echo $count



#ionotropic receptor|ionotropic glutamate receptor|glutamate receptor ionotropic
# for file in *.fasta

# do 
# grep  "^>" $file |grep -iE "(ionotropic receptor|ionotropic glutamate receptor|glutamate receptor ionotropic)" >> ionotropic_receptor.txt

# done

#odorant receptor

# for file in *.fasta
# do
# grep  "^>" $file |grep -iE "odorant receptor" >> odorant_receptor.txt
# done

#gustatory receptors

# for file in *.fasta
# do
# grep "^>" $file |grep -iE "gustatory receptor" >> "gustatory_receptors.txt"
# done

#odorant-binding proteins

# for file in *.fasta
# do
# grep "^>" $file|grep -iE "odorant-binding protein" >> "odorant-binding_protein.txt"
# done

#sensory neuron membrane proteins

# for file in *.fasta
# do
# grep "^>" $file|grep -iE "sensory neuron membrane protein" >> "sensory_neuron_membrane_protein.txt"
# done

#chemosensory protein
# for file in *.fasta
# do
# grep "^>" $file|grep -iE "chemosensory protein" >> "chemosensory_protein.txt"
# done

#Count number of genes per file

# grep -c "^>" *.txt 

or

# find . -name "*.fasta" -exec sh -c 'grep -icE "chemosensory protein" {} | while read -r count; do echo "Count for file {}: $count"; done' \; 
