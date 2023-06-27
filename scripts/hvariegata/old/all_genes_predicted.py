with open ('/home/kebaso/Documents/projects/hippo/hvariegata_female/results/augustus_annotations/protein_seqs.fa','r') as seq:
            count=0
            lines=seq.readlines()
            for line in lines:
                if line.startswith(">"):
                    count +=1
            print(count)