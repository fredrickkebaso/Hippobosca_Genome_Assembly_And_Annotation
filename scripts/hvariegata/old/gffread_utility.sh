#/bin/bash

#gffread utility quick cleanup and a quick visual inspection of a given GFF

file=/home/kebaso/Documents/projects/hippo/hvariegata_female/results/augustus_annotations/hvariegata_f_genome_ann.gff
genome=/home/kebaso/Documents/projects/hippo/hvariegata_female/results/velvet_out/hvariegata_f_genome.fa
outdir=/home/kebaso/Documents/projects/hippo/hvariegata_female/results/augustus_annotations

# gffread -E $file -o- | less
# -E option directs gffread to "expose" (display warnings about) any potential issues encountered while parsing the input file


#Cluster the input transcripts into loci, discarding “duplicated” transcripts (those with the same exact introns and fully contained

# gffread -E --merge $file -o- | less

# gffread -E -P -Z -g -x $genome $file -o- | less

#generate a FASTA file with the DNA sequences for all transcripts in a GFF file. 

gffread \
-g $genome $file \
-w \
$outdir/nucleotide_seqs.fa

# -g file containing the genome sequences,
# input.gff is the GFF file from which the sequences will be extracted and 
# -y option will extract the CDS and translate them to proteins sequences.
# N/B -x - use the x option to obtain the CDS sequences and not  OPTION w
#-w retrieves whole transcripts sequences