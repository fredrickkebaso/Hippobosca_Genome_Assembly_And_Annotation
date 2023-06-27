#!/bin/bash

set -eu

# Filter orthogroup sequences

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/total_genome/Results_May17"
ann_file="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/braker/spades/braker.gff3"
codingSeq="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/braker/spades/braker.codingseq"
genome_file="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/braker/spades/h_variegata_spades_genome.fa"
chem_files="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_proteins_faa_copy/prot_genome_proteins_faa_filtered_ids"
species=(
    "D_melanogaster.fasta"
    "G_brevipalpis.fasta"
    "G_morsitans.fasta"
    "M_domestica.fasta"
    "S_calcitrans.fasta"
    "A_egypti.fasta"
    "A_gambiae.fasta"
    "C_capitata.fasta"
    "lucilia_cuprina.fasta"
    "S_bullata.fasta"
    "G_fuscipes.fasta"
    "B_oleae.fasta"
)
gene_name=(
    "odorant receptor"
    "(ionotropic receptor|ionotropic glutamate receptor|glutamate receptor ionotropic)"
    "gustatory receptor"
    "odorant-binding protein"
    "sensory neuron membrane protein"
    "chemosensory protein"
)
predicted_genes="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/braker/spades/braker.fasta"
predicted_species_name="H_variegata_spades"
results="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/blast_homologs/spades/orthofinder"

echo "Remove output directory if it already exists"
# if [ -d "${results}" ]; then
#   rm -r "${results}"
# fi

# mkdir -p "${results}"

# Extract the predicted gene_ids
echo "Extracting predicted gene IDs..."

# grep "^>" "${predicted_genes}" | sed 's/>//g' > "${results}/${predicted_species_name}_gene_ids.txt"

# Loop through the gene names
for name in "${gene_name[@]}"
do
    # Replace spaces with underscores
    
    
    family_name="${name// /_}"

    # Concatenate chemosensory sequence headers
    echo "Concatenating chemosensory sequence headers for gene family: ${name}..."

    # for sp in "${species[@]}"
    # do
    #     grep -i "^>" "${chem_files}/${sp}" | grep -iE "${name}" | cut -d "|" -f1 | sed 's/>//g' >> "${results}/${family_name}_gene_ids.txt"
    # done

    # Extracting gene ids from the headers

    echo "Extracting gene IDs from the headers for gene family: ${name}..."
    # grep -f "${results}/${family_name}_gene_ids.txt" "${basedir}/Orthogroups/Orthogroups.txt" | cut -f1 -d ":" > "${results}/${family_name}_orthogroups.txt"

    # Extracting sequences from orthogroups
    echo "Extracting sequences from orthogroups for gene family: ${name}..."
    # og=$(cat "${results}/${family_name}_orthogroups.txt")

    # for i in $og
    # do 
        # echo "Processing orthogroup: ${i}..."
        # seqkit grep -f "${results}/${predicted_species_name}_gene_ids.txt" "${basedir}/Orthogroup_Sequences/${i}.fa" >> "${results}/${family_name}.fa"
    # done
    echo ""

    # Extracting predicted gene ids
    # | cut -d "|" -f1 | sed 's/>//g'

    # for sp in "${species[@]}"
    # do
    #     grep  "^>" "${chem_files}/${sp}" | grep -iwE "${gene_name[@]}"  >> "${results}/${family_name}_headers.txt"

    #     grep 
    # done


    

    # for line in $(cat file.txt); do
    #     if [[ $line != *"gustatory and odorant receptor"* ]] && [[ $line == *"odorant receptor"* ]]; then
    #     echo "$line" >> odorant_lines.txt
    #     fi
    # done

   

    grep "^>" "${results}/${family_name}.fa" | sed 's/>//g' > "${results}/${family_name}_predicted_gene_ids.txt"

    grep -f "${results}/${family_name}_predicted_gene_ids.txt" "${ann_file}" > "${results}/${family_name}.gff3"

    cut -f1 "${results}/${family_name}.gff3" | sort | uniq >"${results}/${family_name}_contig_ids.txt"

    seqkit grep -f "${results}/${family_name}_contig_ids.txt" "${genome_file}" >  "${results}/${family_name}.contigs.fa"


    # cut -d " " -f1 "${results}/${family_name}.gff3"

done



grep -c "^>" "${results}"/*.fa



# for file in `ls "${results}/*"`
# do
#     count=$(grep -c "^>" "${file}")
#     prot_name=$(basename ${file} .fa)
#     echo Retrieved : "${count}" "${prot_name}s"
# done

