#!/home/fkebaso/.conda/envs/biopython

#Renames contigs to with short names

from Bio import SeqIO
import os

# Define base directory
basedir = "/mnt/lustre/users/fkebaso/hippo/hvariegata_female/results/spades/"

# Define input files
genome_files = [ os.path.join(basedir, "hvariegata_f_spades_genome_filtered_assembly.fa")]

# Process each input file
for input_file in genome_files:
    output_file = os.path.join(os.path.dirname(input_file), f"{os.path.splitext(os.path.basename(input_file))[0]}_renamed.fa")
    
    # Initialize a counter for sequence numbering
    counter = 1
    
    print(f"Processing file: {input_file}")
    
    # Open the input and output files
    with open(input_file, "r") as input_handle, open(output_file, "w") as output_handle:
        # Iterate over each sequence in the input file
        for record in SeqIO.parse(input_handle, "fasta"):
            # Get the original sequence ID
            original_id = record.id
            
            # Extract the node ID from the original sequence ID
            node_id = original_id.split("_")[-3]
            
            # Create the new sequence ID using the specified format
            new_id = f"contig_{counter}_length_{node_id}"
            
            # Update the record ID and description with the new IDs
            record.id = new_id
            record.description = new_id
            
            # Write the modified record to the output file
            SeqIO.write(record, output_handle, "fasta")
            
            # Increment the counter
            counter += 1
    
    print(f"Renamed sequences saved to: {output_file}")
    print()
