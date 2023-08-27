#!/bin/bash

basedir_1="/home/kebaso/Documents/projects/hippo/hvariegata_female/results/validated_genes"
basedir_2="/home/kebaso/Documents/projects/hippo/hcamelina_male/results/validated_genes/sequences"
results="${basedir_1}/combined_chem_genes"

# Define the validated_files array with the desired pattern
validated_files=("${basedir_1}/sequences"/*_renamed.fa "${basedir_2}"/*_renamed.fa)
validated_genes=("validated_Irs_renamed.fa" "validated_csps_osd_like_renamed.fa" "validated_grs_renamed.fa" 
"validated_ors_renamed.fa" "validated_obps_renamed.fa" "validated_minus_c_obps_renamed.fa" 
"validated_csps_DUF_1091_renamed.fa" "validated_csps_DM_11_renamed.fa" "validated_Irs_ANF_renamed.fa" "validated_Irs_PBP_iGRS_renamed.fa")

# Remove output directory if it already exists
echo "Removing old output directory (if exists)..."
if [ -d "${results}" ]; then
    rm -r "${results}"
fi

echo "Creating results dir..."

mkdir -p "${results}"

for file in "${validated_files[@]}"; do
    file_name=$(basename "$file")
    for gene_name in "${validated_genes[@]}"; do
        if [[ $file_name == "$gene_name" ]]; then
            echo "Concatenating ${file_name}..."
            cat "$file" >> "${results}/${file_name}"
        fi
    done
done

echo Total gene counts: 

grep -c ">" ${results}/*.fa











