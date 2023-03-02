#!/usr/bin/python3

#The script replaces unknown ammino acids (generated with a period (.) by augustus ) with N, this allows blasting as periods are not recognised by the blastp tool.

with open('results/augustus_annotations/protein_seqs.fa','r') as fasta_file:
    with open ('results/augustus_annotations/protein_seqs_masked.fa','w') as prot_seq:
        lines = fasta_file.readlines()
        for seq in lines:
            if seq.startswith('>'):
                prot_seq.write(seq)
            else:
                new_seq=seq.replace(".","N")
                prot_seq.write(new_seq)

#The letter N is used to represent an ambiguous amino acid in a protein sequence. 
# It is often used when the exact amino acid at a particular position in a sequence is not known or cannot be determined. 
# N can represent any of the 20 standard amino acids.
#It is used as a placeholder for any amino acid that is found in the set of 20 standard amino acids in the genetic code and the genetic code table.
# it is used to indicate that the codon codes for any amino acid.