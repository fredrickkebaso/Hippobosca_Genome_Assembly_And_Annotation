#!bin/bash


basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female"
#Find homologs

bash "${basedir}/scripts/13_blastp_search.sh" 

# Extract querie nodes with hits >1

python3 "${basedir}/scripts/14_extarct_query_sequences.py" 

#Extract genesequnces for all transcript isoforms with hits>1

python3 "${basedir}/scripts/16_nucl_seq_extract.py"

#Extract the longest isoform for each transcripts genes

python3 "${basedir}/scripts/best_tr_isoform.py"

#Count the number of genes 

python3 "${basedir}/scripts/17_gene_count.py"