#!/bin/bash

#Obtain chemosensory gene_ids

#Ionotropic gene ids

basedir="/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_proteins_faa_copy/prot_genome_proteins_faa_filtered_ids"

# vectobase_proteins=("D_melanogaster.fasta" "G_brevipalpis.fasta" )


grep "^>" "${basedir}/D_melanogaster.fasta" |grep "gene_product=Ionotropic receptor" > "${basedir}/D_melanogaster_ids.txt"
                                                                                    
grep "^>" "${basedir}/G_brevipalpis.fasta" |grep "gene_product=Ionotropic receptor" |sed 's/^>\([^ ]*\).*/\1/' >> "${basedir}/G_brevipalpis.txt"
