#! /usr/bin/bash

# export PATH="$PATH:/home/manase/Desktop/project_workflows/tools_source_code/seqtk"

# Add gff2gtf.pl to path
# export PATH="$PATH:/home/manase/Desktop/cgenomicsAnalysis/scripts/MB_Orthofinder/braker/longestg"


# activate conda cgat-env check if it exists first
echo Initailizing variables

basedir="/home/kebaso/Documents/projects/hippo/hvariegata_female"
gff_file="${basedir}/results/braker/spades/braker.gff3"
gtf_file="${basedir}/results/braker/spades/braker.gtf"
results="${basedir}/results/braker/spades"

conda activate "cgat"




echo "filtering longest isoform from protein.faa"
echo " "

echo "***********Preparing and formating genomic.faa for this section*************"

"${basedir}/scripts/gff2gtf.pl" "${gff_file}" | grep -w "gene" |sed 's/_id ".*"://' |sed 's/transcript_id/\t/' | cut -f1,2,3,4,5,6,7,8,9 > "${results}/genes_only"

echo "Genomic CDS file created,well formated -- Ok"
echo " "
echo "Continuing to filter longest genes from genomic.CDS -- Ok"

cgat gtf2gtf -I "${results}/genes_only" --method=filter --filter-method=longest-gene > "${results}/genomic.longest_gene.gff"

# echo "longest genes filtered from genomic.CDS,stored in genomic.longest_gene.gff -- Ok"
# echo " "
# echo "Continue,getting gene ids for longest genes from  above file -- Ok"

# grep -w "gene_id" genomic.longest_gene.gff |sed 's/.*gene_id "//g;s/".*//' |sort -u > genomic.longest_gene.gff.id
# echo " "
# echo "Longest gene ids saved,continue to subquerry .faa using the ids -- Ok"

# seqtk subseq protein.fa genomic.longest_gene.gff.id > genomic.longest_gene.proteins.faa

# echo "Longest genes/isoforms saved to genomic.longest-gene.proteins.faa -- Ok"
# echo " "

