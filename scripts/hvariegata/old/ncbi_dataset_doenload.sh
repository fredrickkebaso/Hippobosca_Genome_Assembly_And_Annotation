#!/bin/bash

set -eu

workdir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database"
# ortho_db="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_chemesensory_db"
# genefamdir="chemosensory_CSPs"
# protfile="d_melanogaster_CSPs"
# species="Drosophila melanogaster"
# orthoname="Drosophila_melanogaster"

# Filter gene id file

grep "Bactrocera oleae" ${workdir}/gene_result.txt  | cut -f 3   > ${workdir}/gene_ids.txt

#Download cds sequences

datasets download gene gene-id `paste ${workdir}/gene_ids.txt` \
--include cds \
--include 'product-report' \
--filename ${workdir}/ncbi_dataset.zip 

#Extract the downloaded protein sequences

unzip -d ${workdir} -o ${workdir}/ncbi_dataset.zip 

mv ${workdir}/ncbi_dataset/data/cds.fna  ${workdir}/bactrocera_oleae.fasta

grep "^>" ${workdir}/bactrocera_oleae.fasta| wc -l

#copy to main db

# cat ${workdir}/${genefamdir}/${protfile}_protseq.faa >> ${ortho_db}/${orthoname}.faa

# grep "^>" ${ortho_db}/${orthoname}.faa |  wc -l

# rm ${ortho_db}/${orthoname}.faa
#Delete unnecessary files

rm ${workdir}/ncbi_dataset.zip
rm -r ${workdir}/ncbi_dataset
rm ${workdir}/README.md
rm ${workdir}/{gene_ids.txt,gene_result.txt}

