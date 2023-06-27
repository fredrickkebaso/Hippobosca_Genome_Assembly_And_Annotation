
import pandas as pd

assembly={'hvariegata_female':{"Total size":"159.8 mb","Scaffolds":"221851","Contigs":"670358","Percent gaps":"16.420%","Scaffold N50":"1 KB","Contigs N50":"374"},
          'hcamelina_male':{"Total size":"153.1 mb","Scaffolds":"197926","Contigs":"494046","Percent gaps":"10.042%","Scaffold N50":"1 KB","Contigs N50":"541"},
          'hlongipennis_female':{"Total size":"207.5 mb","Scaffolds":"490498","Contigs":" 814798","Total size":"207.5 mb","Percent gaps":"8.033%","Scaffold N50":"741 KB","Contigs N50":"416"},
          'hcamelina_female':{"Total size":"207.0 mb ","Scaffolds":"497348","Contigs":"823695","Percent gaps":"7.932%","Scaffold N50":"760 KB","Contigs N50":"403"}}
       
df=pd.DataFrame.from_dict(assembly)
print(df)






# with open ('/home/kebaso/Documents/projects/hippo/hvariegata_female/results/busco_stats/busco_plots/short_summary.specific.genome.hvariegata_female.txt','r') as f:
#     data=f.read()
#     lines=str(data)
#     lines = data.split("\n")
#     start_index = lines.index("Assembly Statistics:") + 1
#     end_index = 23
    
#     # Create a dictionary to store the extracted values
#     assembly_stats = {}
    
#     # Loop through the lines and extract the values
    

        
#         # if line.strip() == "":
#         #     continue
#         # key, value = line.split(" ")
#         # print(key)
        
        

    
#     # start_index = lines.index("Assembly Statistics:") + 1
#     # end_index = len(lines)
#     # print(end_index)

    # # Create a dictionary to store the extracted values
    # assembly_stats = {}

    # # Loop through the lines and extract the values
    # for line in lines[start_index:end_index]:
    #     if line.strip() == "":
    #         continue
    #     key, value = line.split("\t")
    #     print(key)
    # #     assembly_stats[key.strip()] = value.strip()

    # # # Print the extracted values
    # print(assembly_stats)