# from Bio import SeqIO

# inputfile = "/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_db/glossina_morstans_morstans.faa"
# outputfile = "//home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/obp_genes.fa"
# ortho_id = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/Results_Apr17/Orthogroups/Orthogroups.txt"

# from Bio import SeqIO

# inputfile = "/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_db/glossina_morstans_morstans.faa"
# outputfile = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/obp_genes.fa"

# # Open the input and output files
# with open(inputfile, "r") as infile, open(outputfile, "w") as outfile:
#     # Parse the input file as a FASTA format
#     records = SeqIO.parse(infile, "fasta")
    
#     # Loop over each record in the input file
#     for record in records:
#         # Check if the record description (i.e., the line starting with ">") contains the phrase "odorant-binding protein"
#         if "odorant-binding protein" in record.description:
#             # Write the record ID (i.e., the text after ">") to the output file
#             outfile.write(record.id + "\n")


from Bio import SeqIO

# define input and output files
inputfile = "/home/kebaso/Documents/projects/hippo/data/databases/close_sp_genome_databases/prot_genome_db/glossina_morstans_morstans.faa"
outputfile = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/obp_genes.fa"
ortho_id = "/home/kebaso/Documents/projects/hippo/hvariegata_female/results/orthofinder/Results_Apr17/Orthogroups/Orthogroups.txt"

# extract IDs for lines containing "odorant receptor" and save to outputfile
with open(outputfile, "w") as out:
    for record in SeqIO.parse(inputfile, "fasta"):
        if "ionotropic" in record.description:
            out.write(record.id + "\n")

# search for extracted IDs in ortho_id file and print corresponding rows to screen
found = False
with open(ortho_id, "r") as ortho:
    for line in ortho:
        for id in open(outputfile, "r"):
            id = id.strip()
            if id in line:
                print(line.strip())
                found = True
                break
        if found:
            break
if not found:
    print("No matches found.")
