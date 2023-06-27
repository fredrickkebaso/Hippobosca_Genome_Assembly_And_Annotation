#!/bin/bash

set -eu

# Filter orthogroup sequences

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/total_genome/Results_May17"
chem_files="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_proteins_faa_copy/prot_genome_proteins_faa_filtered_ids"
species=(
    "D_melanogaster.fasta"
    "G_brevipalpis.fasta"
    "G_morsitans.fasta"
    "M_domestica.fasta"
    "A_gambiae.fasta"
    "G_fuscipes.fasta"
)

#"B_oleae.fasta" "lucilia_cuprina.fasta" "S_calcitrans.fasta" "A_egypti.fasta" "A_egypti.fasta"  "C_capitata.fasta"
    # "S_bullata.fasta"

gene_name=(
    "odorant receptor"
    "(ionotropic receptor|ionotropic glutamate receptor|glutamate receptor ionotropic)"
    "gustatory receptor"
    "odorant-binding protein"
    "sensory neuron membrane protein"
    "chemosensory protein"
    "gustatory and odorant receptor"
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
    family_name="${name// /_}"

    # Concatenate chemosensory sequence headers
    echo "Extracting chemosensory sequence headers for gene family: ${name}..."
    #-iE

    for sp in "${species[@]}"
    do
        
        
        grep  "^>" "${chem_files}/${sp}" | grep -iwE "${name}" | cut -d "|" -f1 | sed 's/>//g' >> "${results}/${family_name}.txt"

    done

    
    #Extract odorant receptors


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

