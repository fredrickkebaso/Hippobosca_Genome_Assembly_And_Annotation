
#!/bin/bash

set -eu

genome=/home/kebaso/Documents/projects/hippo/hvariegata_female/results/velvet_out/hvariegata_f_genome.fa
workdir=/home/kebaso/Documents/projects/hippo/hvariegata_female/results/augustus_annotations

# convert gff3 to gtf

gffread \
-E \
${workdir}/hvariegata_f_genome_ann.gff \
-T \
--merge \
-t longest \
-d ${workdir}/hvariegata_f_genome_ann_duplicates.gtf \
-o ${workdir}/hvariegata_f_genome_ann.gtf

# --keep-genes 
#  GFFread-Filter, convert or cluster GFF/GTF/BED records, extract the sequence of
#  transcripts (exon or CDS) and more.
# -E expose (warn about) duplicate transcript IDs and other potential
#        problems with the given GFF/GTF records
# -T    main output will be GTF instead of GFF3
# -M/--merge : cluster the input transcripts into loci, discarding
#       "redundant" transcripts (those with the same exact introns
#       and fully contained or equal boundaries)
#  -d <dupinfo> : for -M option, write duplication info to file <dupinfo>
# -o    write the output records into <outfile> instead of stdout
#  -O   process other non-transcript GFF records (by default non-transcript)
#  -M/--merge : cluster the input transcripts into loci, discarding
#       "redundant" transcripts (those with the same exact introns
#       and fully contained or equal boundaries)



#sort the input gtf file by cordinates.

sort -k1,1 -k4,4n ${workdir}/hvariegata_f_genome_ann.gtf > ${workdir}/hvariegata_f_genome_ann_sorted.gtf

#Extract the gene and protein sequences
python3 /home/kebaso/Documents/projects/hippo/gittools/Augustus/scripts/getAnnoFastaFromJoingenes.py \
--genome ${genome} \
--filter_out_invalid_stops FILTER \
--out ${workdir}/hvariegata_f_genome \
--gtf ${workdir}/hvariegata_f_genome_ann_sorted.gtf







# #   -h, --help            show this help message and exit
# #   -g GENOME, --genome GENOME
# #                         genome sequence file (FASTA-format)
# #   -o OUT, --out OUT     name stem pf output file with coding sequences and protein sequences (FASTA-format); will be extended by .codingseq/.aa
# #   -t TRANSLATION_TABLE, --table TRANSLATION_TABLE
# #                         Translational code table number (INT)
# #   -s FILTER, --filter_out_invalid_stops FILTER
# #                         Suppress output of protein sequences that contain internal stop codons.
# #   -p, --print_format_examples
# #                         Print gtf/gff3 input format examples, do not perform analysis
# #   -f GTF, --gtf GTF     file with CDS coordinates (GTF-format)
# #   -3 GFF3, --gff3 GFF3  file with CDS coordinates (GFF3 format)










# #This Python script extracts CDS features from a GTF file, excises
# # corresponding sequence windows from a genome FASTA file, stitches the
# # codingseq parts together, adds letters N at the ends if bases are
# # annotated as missing by frame in the GTF file, makes reverse complement
# # if required, and translates to protein sequence.
# # Output files are:
# #    * file with protein sequences in FASTA format,
# #    * file with coding squences in FASTA format
# # The script automatically checks for in-frame stop codons and prints a
# # warning to STDOUT if such genes are in the GTF-file. The IDs of bad genes
# # are printed to a file bad_genes.lst. Option -s allows to exclude bad genes
# # from the FASTA output file, automatically.
# # Beware: the script assumes that the gtf input file is sorted by coordinates!