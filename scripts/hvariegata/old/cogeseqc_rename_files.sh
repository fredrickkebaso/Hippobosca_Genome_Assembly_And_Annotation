#!/bin/bash

basedir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_ids_and_ann_ids"

# Loop over files with .txt extension in the base directory and its subdirectories
find "$basedir" -type f -name "*.txt" -print0 | while IFS= read -r -d $'\0' file; do
    # Use awk to remove the second column (Source ID) and overwrite the file
    awk 'BEGIN {FS=OFS="\t"} {print $1, $3}' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done


#My genome renaming
echo "transcript_id gene_id" > H_variegata_spades && cut -f9 H_variegata_spades.gtf | awk -F'"' '!seen[$2" "$4]++ {print $2, $4}' >> H_variegata_spades