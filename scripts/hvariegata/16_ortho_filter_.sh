#!/bin/bash

set -eu

# Filter orthogroup sequences

# Set the base directory path
basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/spades"

# Specify the input files
ann_file="${basedir}"/braker.gtf
genome_file="${basedir}"/genome.fa
chem_files="${basedir}"/prot_genome_proteins_faa_filtered_ids
predicted_genes="${basedir}/braker.fasta"
predicted_species_name="hvariegata_f_spades"
results="${basedir}/chemosensory_genes"


# Specify the species and gene families to process
species=("D_melanogaster.fasta"
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

# Specify control genes
control_genes=("FBpp0111921" "GBRI004368-PA" "GMOY004222-PA" "GFUI18_012955.P21290" "FBpp0079371" "GBRI036342-PA" "GMOY004392-PA" "GFUI18_011542.P18799" "FBpp0071782" "GMOY006081-PA" "GMOY005400-PA" "GFUI18_008313.P12793" "FBpp0077386" "GBRI039848-PA" "GMOY011615-PA" "GFUI18_005954.P8780" "FBpp0079291" "GBRI029095-PA" "GMOY005284-PA" "GFUI18_006381.P9508" "GBRI029848-PA" "GMOY013276-PA" "FBpp0306711")


# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d ${results} ]; then
    rm -r ${results}
fi

# Create the output directory
mkdir -p "${results}"

# Extract the predicted gene_ids
echo "Extracting predicted gene IDs..."

# Use grep to extract lines starting with ">" (sequence headers) from the predicted_genes file
# Then use sed to remove the ">" symbol and save the gene IDs in the predicted_species_name_ids.txt file
grep "^>" "${predicted_genes}" | sed 's/>//g' > "${results}/${predicted_species_name}_ids.txt"

# Add control genes to the predicted_species_name_ids.txt file
for sample in "${control_genes[@]}"
do
    echo $sample >> "${results}/${predicted_species_name}_ids.txt"
done

# Loop through the gene names
for name in "${gene_name[@]}"
do
    # Replace spaces with underscores in the gene name and save it in the family_name variable
    family_name="${name// /_}"

    # Concatenate chemosensory sequence headers
    echo "Extracting chemosensory sequence headers for gene family: ${name}..."

    # Loop through each species
    for sp in "${species[@]}"
    do
        if [[ "${name}" == "odorant receptor" ]]; then
            # Use grep to filter lines starting with ">" from the chem_files/sp file
            # Exclude lines containing "gustatory and odorant receptor" and select lines matching "odorant receptor" case-insensitively
            # Use cut to extract the first field (gene ID) delimited by " "
            # Use sed to remove the ">" symbol and save the gene IDs in the family_name.txt file
            grep "^>" "${chem_files}/${sp}" | grep -v "gustatory and odorant receptor" | grep -iwE "odorant receptor" | cut -d " " -f1 | sed 's/>//g' >> "${results}/${family_name}.txt"
        else
            # Use grep to filter lines starting with ">" from the chem_files/sp file
            # Select lines matching the gene name case-insensitively
            # Use cut to extract the first field (gene ID) delimited by " "
            # Use sed to remove the ">" symbol and save the gene IDs in the family_name.txt file
            grep "^>" "${chem_files}/${sp}" | grep -iwE "${name}" | cut -d "|" -f1 | sed 's/>//g' >> "${results}/${family_name}.txt"
        fi
    done

    # Extracting gene IDs from the headers
    echo "Extracting gene IDs from the headers for gene family: ${name}..."

    # Use grep to filter lines matching the gene IDs in the family_name.txt file from the Orthogroups.txt file
    # Use cut to extract the first field (gene ID) delimited by ":"
    # Save the gene IDs in the family_name_ids.txt file
    grep -f "${results}/${family_name}.txt" "${basedir}/Orthogroups.txt" | cut -f1 -d ":" > "${results}/${family_name}_ids.txt"

    # Extracting sequences from orthogroups
    echo "Extracting sequences from orthogroups for gene family: ${name}..."

    # Read the orthogroup IDs from the family_name_ids.txt file
    og=$(cat "${results}/${family_name}_ids.txt")

    # Loop through each orthogroup ID
    for i in $og
    do
        echo "Processing orthogroup: ${i}..."

        # Use seqkit grep to extract sequences from the orthogroup file based on the predicted_species_name_ids.txt file
        # Append the extracted sequences to the family_name.fa file
        seqkit grep -f "${results}/${predicted_species_name}_ids.txt" "${basedir}/Orthogroup_Sequences/${i}.fa" >> "${results}/${family_name}.fa"
    done

    echo ""

    # Extract contig IDs from the gene annotations (GFF3) file
    grep "^>" "${results}/${family_name}.fa" | sed 's/>//g' > "${results}/${family_name}_predicted_gene_ids.txt"

    # Use grep to filter lines matching the gene IDs in the family_name_predicted_gene_ids.txt file from the ann_file
    # Save the filtered lines (contig IDs) in the family_name_contig_ids.txt file
    grep -f "${results}/${family_name}_predicted_gene_ids.txt" "${ann_file}" > "${results}/${family_name}.gff3"

    # Use cut to extract the first field (contig ID) from the family_name.gff3 file
    # Sort and remove duplicate contig IDs
    # Save the unique contig IDs in the family_name_contig_ids.txt file
    cut -f1 "${results}/${family_name}.gff3" | sort | uniq >"${results}/${family_name}_contig_ids.txt"

    # Use seqkit grep to extract sequences from the genome_file based on the family_name_contig_ids.txt file
    # Save the extracted sequences in the family_name.contigs.fa file
    seqkit grep -f "${results}/${family_name}_contig_ids.txt" "${genome_file}" > "${results}/${family_name}.contigs.fa"
done

# Count the number of sequences in each generated family_name.fa file
grep -c "^>" ${results}/*.fa



