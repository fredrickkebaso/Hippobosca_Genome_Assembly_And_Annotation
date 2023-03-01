#!/bin/python3

#Extracts query hits per node per a species

import pandas as pd
import os

# import pandas as pd
# import os

file_path= "/home/kebaso/Documents/projects/hippo/hvariegata/hv_test_pipeline/results/blast_homologs/e_value-5/"

# for db_dir in os.listdir(file_path):
#     base_dir = os.path.join(file_path, db_dir)
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
        # print(queries_dict)
        species_hit_dict = {}
        for query, items in queries_dict.items():
            unique_items = set(items)
            for item in unique_items:
                species_hit_dict[query] = species_hit_dict.get(query, {})
                species_hit_dict[query][item] = items.count(item)

        df = pd.DataFrame(species_hit_dict)
        # df.reset_index()
        # df.rename(columns={"index": "Organism"}, inplace=True)
        df.fillna(0, inplace=True)
        df.astype(int)
        #df_trans=df.transpose()
       # df_trans.columns = [(org for org in species_hits[1] )]

        print(homo_file)
        print(df)


    #for node in line:
    #     elif query.startswith ('NODE'):
    #         species_list=query.split()
    #         species_hits=[(species_list[1].split('_'))]
    #         for i in species_hits:
    #             species_dict[species_hits_list.append(i[1])]=1
    # print(species_dict)


            # counts = Counter(x[1] for x in species_hits)
            # print(counts)
            

            # counts = Counter(species_hits[[1]])
            # #     print(counts)
            # print(counts)
            # # for sp in species_hits:
            # #     print(sp)
            # # #     species_dict[sp]=sp[0]
            # #     )
