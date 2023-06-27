#!/bin/bash

#Functional annotation of proteins

echo loading required modules...

module load chpc/BIOMODULES
module add interproscan/5.61-93.0

basedir="/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results"
prot_sequences="${basedir}/braker/spades/h_variegata_spades_genes.faa"
results="${basedir}/interproscan"
threads=50

echo "Removing asterisks in case they exist in your protein file..."

# Remove asterisks using sed and save to stripped_prot_seq.fa
sed 's/\*//g' "$prot_sequences" >> "${results}/stripped_prot_seq.fa"

echo Running Functional annotations... 

interproscan.sh --input ${results}/stripped_prot_seq.fa --cpu ${threads} --output-dir ${results} 


#-pa,--pathways >  ptional, switch on lookup of corresponding Pathway annotation (IMPLIES -iprlookup option)
# -cpu,--cpu <CPU>        Optional, number of cores for inteproscan.
# #-d,--output-dir <OUTPUT-DIR> Optional, output directory.  Note that this option, the --outfile (-o) option and the --output-file-base (-b) option
#  are mutually exclusive. The output filename(s) are the same as the input filename, with the appropriate file extension(s) for the output format(s) appended automatically .
# -goterms,--goterms >  Optional, switch on lookup of corresponding Gene Ontology annotation (IMPLIES -iprlookup option)
# -i,--input <INPUT-FILE-PATH> Optional, path to fasta file that should be loaded on Master startup. Alternatively, in CONVERT mode, the InterProScan 5 XML file to convert.
#-iprlookup,--iprlookup > Also include lookup of corresponding InterPro annotation in the TSV and GFF3 output formats.
