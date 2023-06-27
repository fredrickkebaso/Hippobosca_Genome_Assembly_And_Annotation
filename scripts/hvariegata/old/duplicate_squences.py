import glob
import os
from Bio import SeqIO

input_files = glob.glob("/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_database/orthofinder_db/*.faa")
output_dir = "/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_database/orthofinder_db"
num_duplicates=9
# Loop over input files
for input_file in input_files:
    output_filename = os.path.basename(input_file).replace(".faa", "_duplicates.faa")
    output_file = os.path.join(output_dir, output_filename)

    # Read input sequences
    sequences = list(SeqIO.parse(input_file, "fasta"))

    # Create duplicates
    duplicated_sequences = []
    for i in range(1, num_duplicates + 1):
        for seq in sequences:
            duplicated_seq = SeqIO.SeqRecord(seq.seq, id=f"{seq.id}_Duplicates-{i}",
                                             description=f"{seq.description}_Duplicates-{i}")
            duplicated_sequences.append(duplicated_seq)

    # Combine original and duplicated sequences
    all_sequences = sequences + duplicated_sequences

    # Write all sequences to output file
    with open(output_file, "w") as outfile:
        SeqIO.write(all_sequences, outfile, "fasta")
