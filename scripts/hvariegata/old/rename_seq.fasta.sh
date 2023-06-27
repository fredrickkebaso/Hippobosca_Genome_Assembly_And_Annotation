#!/bin/bash

# Renames the fasta sequence headers

set -eu  # Exit immediately if any command exits with a non-zero status

workdir=/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database

for file in ${workdir}/*_nucl.fasta; do  # Loop through all *_nucl.fasta files in the workdir directory
    sed -Ei 's/^>([^ ]+).*/>\1/' "$file"  # Replace the header of each sequence with the first word in the header, and save the changes to the file
    # The regular expression ^>([^ ]+).* matches the entire header line, and captures the first word (i.e., the gene ID) in a group using ([^ ]+).
    # The replacement string is just \1, which is the first captured group (i.e., the gene ID) preceded by the > character.
    # The -E option tells sed to use extended regular expressions, and the -i option tells sed to edit the file in place.
done

lucilia=/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database/lucilia_cuprina_nucl.fasta
bactrocera=/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database/bactrocera_oleae_nucl.fasta
ceratitis=/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database/ceratitis_capitata_nucl.fasta

# Replace the colon in the header of the Lucilia FASTA file with a period
sed -Ei 's/^(>[^:]+):/\1./' $lucilia
# The regular expression ^(>[^:]+): matches the entire header line up to and including the colon character (:), and captures everything in between in a group using ([^:]+).
# The replacement string is just \1., which is the first captured group (i.e., the gene ID) followed by a period (.) character and preceded by the > character.
# The -E option tells sed to use extended regular expressions, and the -i option tells sed to edit the file in place.

# Replace the colon in the header of the Bactrocera FASTA file with a period
sed -Ei 's/^(>[^:]+):/\1./' $bactrocera
# Same as above, but applied to the Bactrocera FASTA file.

# Replace the colon in the header of the Ceratitis FASTA file with a period
sed -Ei 's/^(>[^:]+):/\1./' $ceratitis
# Same as above, but applied to the Ceratitis FASTA file.


#Rename fasta headers to retain only the uniq ids
sed -i 's/^>\([^ ]*\).*/>\1/' filename.fasta
# This command captures the sequence identifier between ">" and the first space character using a capture group.
# It replaces the entire matched line with the captured identifier (\1). 
# This way, the sequence identifier is preserved while removing the rest of the header.

# By executing this command, the sequence identifiers in your multifasta file will be renamed based on the dynamic values present 
# in the original file. Remember to replace "your_file.fasta" with the actual name of your multifasta file.


#
grep -h '^>' *.faa | sort | uniq -d

# This command performs the following steps:

# grep -h '^>' *.faa: This command searches for lines starting with ">" (fasta headers) in all files ending with ".faa". The -h option suppresses the filename in the output, showing only the matching lines.

# sort: The output of the previous command is piped to sort to sort the headers in ascending order.

# uniq -d: The sorted headers are then piped to uniq -d to print only the duplicate (identical) headers.


