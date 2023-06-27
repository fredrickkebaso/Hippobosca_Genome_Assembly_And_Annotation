from Bio import SeqIO

# input and output file paths
input_file = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results/augustus_annotations/hvariegata_f_genome_ann.gff"
output_file = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results/augustus_annotations/hvariegata_f_genome_ann_cleaned.gff"

# open input and output files
with open(input_file, "r") as in_handle, open(output_file, "w") as out_handle:
    # iterate through GFF3 records
    for record in SeqIO.parse(in_handle, "gff"):
        # filter out comment lines
        if not record.id.startswith("#"):
            # write only feature lines to output file
            for feature in record.features:
                out_handle.write("{}\n".format(feature))
