#!/bin/bash

set -eu

# Filter orthogroup sequences

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/hackathon"
chem_files="${basedir}/prot_genome_proteins_faa_filtered_ids"
species=(
    "D_melanogaster.fasta"
    "G_brevipalpis.fasta"
    "G_morsitans.fasta"
    "M_domestica.fasta"
    "A_gambiae.fasta"
    "G_fuscipes.fasta"
    "B_oleae.fasta" 
    "lucilia_cuprina.fasta" 
    "S_calcitrans.fasta" 
    "A_egypti.fasta" 
    "C_capitata.fasta"
    "S_bullata.fasta")
gene_name=(
    "odorant receptor"
    "(ionotropic receptor|ionotropic glutamate receptor|glutamate receptor ionotropic)"
    "gustatory receptor"
    "odorant-binding protein"
    "sensory neuron membrane protein"
    "chemosensory protein"
    "gustatory and odorant receptor"
)

control_genes=("FBpp0111921" "GBRI004368-PA" "GMOY004222-PA" "GFUI18_012955.P21290" "FBpp0079371" "GBRI036342-PA" "GMOY004392-PA" "GFUI18_011542.P18799" "FBpp0071782" "GMOY006081-PA" "GMOY005400-PA" "GFUI18_008313.P12793" "FBpp0077386" "GBRI039848-PA" "GMOY011615-PA" "GFUI18_005954.P8780" "FBpp0079291" "GBRI029095-PA" "GMOY005284-PA" "GFUI18_006381.P9508" "GBRI029848-PA" "GMOY013276-PA" "FBpp0306711")

predicted_genes="${basedir}/braker.fasta"
predicted_species_name="H_variegata_spades"
results="${basedir}/results"


mkdir -p "${results}"

# Extract the predicted gene_ids
echo "Extracting predicted gene IDs..."

grep "^>" "${predicted_genes}" | sed 's/>//g' > "${results}/${predicted_species_name}_ids.txt"

#Add control genes
for sample in "${control_genes[@]}"
do
    echo $sample >> "${results}/${predicted_species_name}_ids.txt"

done

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
    if [[ "${name}" == "odorant receptor" ]]; then
        grep "^>" "${chem_files}/${sp}" | grep -v "gustatory and odorant receptor" | grep -iwE "odorant receptor" | cut -d "|" -f1 | sed 's/>//g' >> "${results}/${family_name}.txt"
    else
        grep "^>" "${chem_files}/${sp}" | grep -iwE "${name}" | cut -d "|" -f1 | sed 's/>//g' >> "${results}/${family_name}.txt"
    fi
    done



    #Extract odorant receptors


    # Extracting gene ids from the headers

    echo "Extracting gene IDs from the headers for gene family: ${name}..."

    grep -f "${results}/${family_name}.txt" "${basedir}/Orthogroups.txt" | cut -f1 -d ":" > "${results}/${family_name}_ids.txt"

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






