import os

#Extracts gene sequences for the identified chemosensory gene homologs from a genome file

basedir = "/home/kebaso/Documents/projects/hippo/hvariegata_female"
hits_file = f"{basedir}/results/blast_homologs/spades"
codingseq_file=f"{basedir}/results/braker/spades/braker.codingseq"

print("Extracting gene sequences from genome file...")

#Extracts raw genome node/queries to a dictionery
sequences = {}
with open(codingseq_file) as file: 
    genome_seq_id = ""
    genome_seq = ""
    for genome_line in file:
        if genome_line.startswith(">"):
            # genome_line=genome_line.replace(">", "")
            if genome_seq_id:
                sequences[genome_seq_id] = genome_seq
                genome_seq = ""
            genome_seq_id = genome_line 
        else:
            genome_seq += genome_line.strip()
# Add the last sequence
sequences[genome_seq_id] = genome_seq
#open and extract hit headers or identifiers and add them to a list, gene-query_list

# print(sequences)
for file in os.listdir(hits_file):
    if file.endswith ("hits.txt"):
        hits_path=os.path.join(hits_file, file)
        
        # print (hits_path)
        gene_file,extension=os.path.splitext(os.path.basename(hits_path))
        gene_file=gene_file.split('_')[0]
        # print(gene_file)
        gene_seq_file=os.path.join(hits_file,gene_file + "_homolog_hits_gene_seqs.fa") #creates new files to append extracted sequences
        # print(gene_seq_file)
        with open (hits_path,'r') as prot_seq:
            with open(gene_seq_file,'w') as seq_file:
                gene_query=[]
                gene_line=prot_seq.readlines()
                # print(gene_line)
                for gene_node in gene_line:
                    if gene_node.startswith ('# Query:'):
                        # print(gene_node)
                        parts = gene_node.split(": ")
                        query = ">" + parts[1]
                        gene_query.append(query)
                for node in gene_query:
                    for seq_id, seq in sequences.items():
                        # print(seq_id)
                        # print(gene_query)
                        if seq_id==node:
                            # print(seq_id)
                            line=f"{seq_id}\n{seq}\n"
                            seq_file.write(line)
            print(f"Extracted sequences written to {gene_seq_file}")













#-----------------------------------Gene Nodes---------------------------------------

# import os

# #Extracts gene sequences for the identified chemosensory gene homologs from a genome file

# basedir = "/home/kebaso/Documents/projects/hippo/hvariegata_female"
# hits_file = f"{basedir}/results/blast_homologs/spades"
# codingseq_file=f"{basedir}/results/braker/spades/braker.codingseq"

# print("Extracting gene sequences from genome file...")

# #Extracts raw genome node/queries to a dictionery
# sequences = {}
# with open(codingseq_file) as file: 
#     genome_seq_id = ""
#     genome_seq = ""
#     for genome_line in file:
#         if genome_line.startswith(">"):
#             if genome_seq_id:
#                 sequences[genome_seq_id] = genome_seq
#                 genome_seq = ""
#             genome_seq_id = genome_line 
#         else:
#             genome_seq += genome_line.strip()
# # Add the last sequence
# sequences[genome_seq_id] = genome_seq
# #open and extract hit headers or identifiers and add them to a list, gene-query_list
# for file in os.listdir(hits_file):
#     if file.endswith ("hits.txt"):
#         hits_path=os.path.join(hits_file, file)
#         gene_file,extension=os.path.splitext(os.path.basename(hits_path))
#         gene_file=gene_file.split('_')[0]
#         # print(gene_file)
#         gene_seq_file=os.path.join(hits_file,gene_file + "_homolog_hits_gene_seqs.fa") #creates new files to append extracted sequences
#         # print(gene_seq_file)
#         with open (hits_path,'r') as prot_seq:
#             with open(gene_seq_file,'w') as seq_file:
#                 gene_query=[]
#                 gene_line=prot_seq.readlines()
                
#                 for gene_node in gene_line:
#                     if gene_node.startswith ('# Query:'):
#                         # print(gene_node)
#                         #print(gene_node)
                        # gene_node_parts = gene_node.split("_")
#                         # print(gene_node_parts)
                        # gene_query_node= int(gene_node_parts[1])

#                         # gene_query_node= int(gene_node.split("_")[1])
#             #             if gene_query_node not in gene_query:
#             #                 gene_query.append(gene_query_node)
#                 for node in gene_query:
#                     for seq_id, seq in sequences.items():
#                         gene_id = seq_id.strip().split("_")[1]
#                         # print(node)
#                         if int(gene_id)==node:
#                             line=f"{seq_id}\n{seq}\n"
#                             seq_file.write(line)
#             print(f"Extracted sequences written to {gene_seq_file}")
