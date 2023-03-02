#!/bin/python3

#Extracts query hits per node per a species in the database

import pandas as pd
import os

file_path= "/home/kebaso/Documents/projects/hippo/hcamelina_f/results/blast_homologs/e_value-5/"

for file in os.listdir(file_path):
    if file.endswith("hits.txt"):
        homo_file=os.path.join(file_path, file)
        queries_dict = {}
        current_query = None
        with open (homo_file,"r") as f:
            line=f.readlines()
            species_dict=[]
            for query in line:
                species_hits_list=[]
                if query.startswith('# Query:'):
                    current_query = query.strip()
                    queries_dict[current_query] = []
                elif query.startswith ('NODE'):
                    species_list=query.split()
                    species_hits=(species_list[1].split('_'))            
                    queries_dict[current_query].append(species_hits[1])
        species_hit_dict = {}
        for query, items in queries_dict.items():
            unique_items = set(items)
            for item in unique_items:
                species_hit_dict[query] = species_hit_dict.get(query, {})
                species_hit_dict[query][item] = items.count(item)

        df = pd.DataFrame(species_hit_dict)
        df.fillna(0, inplace=True)
        df.astype(int)
        print(homo_file)
        print(df)


    
    