#!/bin/bash

# Set the working directory
workdir=/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_gene_cds_database

# Loop over input files
for inputfile in ${workdir}/*_nucl.fasta
do
  # Set the output filename based on the input filename
  outputfile="${inputfile%_nucl.fasta}_prot.fasta"

  # Run TransDecoder to translate the sequences
  TransDecoder.LongOrfs -t "${inputfile}"
  TransDecoder.Predict -t "${inputfile}" --single_best_orf -m 10

  # Rename and move the output file
  mv "${inputfile}.transdecoder.pep" "${outputfile}"
done


# set -eu

# workdir=/home/kebaso/Documents/projects/hippo/hvariegata_female/results

# mkdir -p ${workdir}/transdecoder

# # Run TransDecoder on the FASTA file to predict ORFs and filter based on coding potential

# TransDecoder.LongOrfs \
# -t ${workdir}/augustus_annotations/hvariegata_f_genome.aa \
# --output_dir ${workdir}/transdecoder/hvariegata_F_genome

# # #    -t <string>                            transcripts.fasta
# # #   -m <int>                               minimum protein length (default: 100) 
# # #   -S                                     strand-specific (only analyzes top strand)
# # #   --output_dir | -O  <string>            path to intended output directory (default:  basename( -t val ) + ".transdecoder_dir")

# TransDecoder.Predict \
# -t ${workdir}/augustus_annotations/hvariegata_f_genome.aa \
# --single_best_only \
# --output_dir ${workdir}/transdecoder/hvariegata_F_genome

# # # --single_best_only  Retain only the single best orf per transcript (prioritized by homology then orf length)
# # ##   --output_dir | -O  <string>            output directory from the TransDecoder.LongOrfs step (default: basename( -t val ) + ".transdecoder_dir")

# rm pipeliner*
# rm -r ${workdir}/transdecoder/{hvariegata_F_genome,hvariegata_F_genome.__checkpoints,hvariegata_F_genome.__checkpoints_longorfs}

# # # Extract the best quality ORF from the TransDecoder output

# dir=/home/kebaso/Documents/projects/hippo/hvariegata_female/hvariegata_f_genome.aa.transdecoder.pep
# # grep ">" ${dir} | cut -d " " -f 1,5 | sed 's/|/\t/g' | sort -k1,1 -k6,6gr | sort -u -k1,1 --merge | cut -f 1 | sed 's/>//g' > ${workdir}/transdecoder/best_isoforms.txt
# grep ">" ${dir}  | cut -d " " -f 1,5 | sed 's/|/\t/g' | sort -k1,1 -k6,6gr | sort -u -k1,1 --merge | cut -f 1,4,5,9 | sed 's/:/\t/g' | sed 's/-/\t/g' | awk '{print $1"\t"$2-1"\t"$3"\t"$4"\t0\t"$6}' > ${workdir}/transdecoder/best_isoforms.bed



# # Extract the best quality isoform sequences from the original FASTA file
# seqtk subseq \
# ${workdir}/augustus_annotations/hvariegata_f_genome.aa \
# ${workdir}/transdecoder/best_isoforms.txt > ${workdir}/transdecoder/best_isoforms.fasta