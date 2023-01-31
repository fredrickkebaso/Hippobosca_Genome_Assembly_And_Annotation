# open the BLASTp text file
#Extracts queries with hits > 1, Fields and the number of hits found and the corresponding hits.

import os

file_path= "results/blast_homologs/e_value-5"

for file in os.listdir(file_path):
    file_dir = os.path.join(file_path, file)
    hits_file,extension=os.path.splitext(os.path.basename(file_dir))
    prot_file=os.path.join(file_path,hits_file + "_hits.txt")
    with open(file_dir,'r') as f:
        with open (prot_file,'w') as prot_hits:
            # read the contents of the file into a list of lines
            lines = f.readlines()
            # iterate through the lines in the file
            for i,line in enumerate (lines):
                # check if the line starts with "#"
                if line.startswith("# Fields"):
                    # this is a header line, 
                    prot_hits.write("\n"*2)
                    prot_hits.write(lines[i-2])
                    prot_hits.write(lines[i+1])
                    prot_hits.write(line)
                elif not line.startswith("#"):
                    # this is the start of a hit
                    prot_hits.write(line)
    

