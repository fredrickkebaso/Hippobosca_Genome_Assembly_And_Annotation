from Bio import SeqIO
import glob

basedir = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/total_genome/Results_May17/Orthogroups/Orthogroups.txt"

nested_list = []

with open(basedir, 'r') as file:
    for line in file:
        line = line.strip()  # Remove leading/trailing whitespace
        if line:
            orthogroup, *values = line.split()  # Split line by whitespace
            dictionary = {orthogroup: values}  # Create a dictionary with orthogroup as the key and values as the corresponding list
            nested_list.append(dictionary)  # Append the dictionary to the nested list


chem_files = "/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_proteins_faa_copy/prot_genome_proteins_faa_filtered_ids/D_melanogaster_ids.txt"

gene_dict = {}

for file_path in glob.glob(chem_files):
    gene_family = file_path.split("/")[-1]  # Extract the file name from the file path
    gene_ids = []
    for record in SeqIO.parse(file_path, "fasta"):
        gene_id = record.id
        gene_ids.append(gene_id)
    gene_dict[gene_family] = gene_ids

# Mapping gene families to orthogroups
mapping_results = {}

for orthogroup_dict in nested_list:
    for orthogroup, orthogroup_values in orthogroup_dict.items():
        matching_gene_families = []
        for gene_family, gene_family_values in gene_dict.items():
            if any(gene_value in orthogroup_values for gene_value in gene_family_values):
                matching_gene_families.append(gene_family)
        if len(matching_gene_families) == 1:  # Check if only a single gene family matches
            orthogroup_contents = orthogroup_values  # Store all orthogroup values
            mapping_results[orthogroup] = orthogroup_contents

# Combine values for each gene family
combined_values = {}

for orthogroup_contents in mapping_results.values():
    for value in orthogroup_contents:
        gene_family = next(iter(gene_dict))
        if gene_family in combined_values:
            combined_values[gene_family].append(value)
        else:
            combined_values[gene_family] = [value]
    
# Remove duplicates from combined values
for gene_family, values in combined_values.items():
    combined_values[gene_family] = list(values)

print (combined_values)
from collections import Counter

# Count the values for each key in combined values
key_value_counts = {}
for gene_family, values in combined_values.items():
    value_counts = Counter(values)
    key_value_counts[gene_family] = value_counts


# # Print the value counts for each key
# for gene_family, value_counts in key_value_counts.items():
#     print(f"Gene Family: {gene_family}")
#     for value, count in value_counts.items():
#         print(f"Value: {value} \t Count: {count}")
#     print()