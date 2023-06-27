#!/bin/bash

set -eu

# Filter orthogroup sequences

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/total_genome/Results_May17"
chem_files="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_proteins_faa_copy/prot_genome_proteins_faa_filtered_ids/species"    
gene_name=(
    "chemosensory_protein.txt"
    "gustatory_receptors.txt"
    "ionotropic_receptor.txt"
    "odorant-binding_protein.txt"
    "odorant_receptor.txt"
    "sensory_neuron_membrane_protein.txt"
)

predicted_genes="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/braker/spades/braker.fasta"
predicted_species_name="H_variegata_spades"
results="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/blast_homologs/spades/orthofinder"

echo "Remove output directory if it already exists"
if [ -d "${results}" ]; then
  rm -r "${results}"
fi

mkdir -p "${results}"

# Extract the predicted gene_ids
echo "Extracting predicted gene IDs..."

grep "^>" "${predicted_genes}" | sed 's/>//g' > "${results}/${predicted_species_name}_ids.txt"

# Loop through the gene names
for name in "${gene_name[@]}"
do
    # Replace spaces with underscores
    family_name="$(basename $name .txt)"

    # Concatenate chemosensory sequence headers
    echo "Extracting chemosensory sequence headers for gene family: ${name}..."

    # for sp in "${species[@]}"
    # do
    grep -i "^>" "${chem_files}/${name}" | cut -d "|" -f1 | sed 's/>//g' >> "${results}/${family_name}.txt"
    # done


     # Extracting gene ids from the headers

    echo "Extracting gene IDs from the headers for gene family: ${name}..."
    grep -f "${results}/${family_name}.txt" "${basedir}/Orthogroups/Orthogroups.txt" | cut -f1 -d ":" > "${results}/${family_name}_ids.txt"

    # Extracting sequences from orthogroups
    echo "Extracting sequences from orthogroups for gene family: ${name}..."
    og=$(cat "${results}/${family_name}_ids.txt")

    for i in $og
    do 
        echo "Processing orthogroup: ${i}..."
        seqkit grep -f "${results}/${predicted_species_name}_ids.txt" "${basedir}/Orthogroup_Sequences/${i}.fa" >> "${results}/${family_name}.fa"
    done
    echo ""

    # echo Retrieved : $(grep -c "^>" "${results}/${family_name}.fa") "${name}s" 

done


grep -c "^>" ${results}/*.fa

# for file in `ls "${results}/*"`
# do
#     count=$(grep -c "^>" "${file}")
#     prot_name=$(basename ${file} .fa)
#     echo Retrieved : "${count}" "${prot_name}s"
# done

