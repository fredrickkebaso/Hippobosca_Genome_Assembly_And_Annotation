# De-novo-Genome-Assembly-and-chemosensory-gene-annotation-in-three-Hippobosca-species


## Background of the study

***Hippoboscids*** (keds/flies) are obligate hematophagous or blood-sucking ectoparasites that infest birds, mammals, and rarely humans. They vector pathogens such as *Anaplasma camelii* and *Acanthocheilonema dracunculoides*. The keds require about 1.5mg of blood in a span of 6 hours at an interval of 13 minutes as such heavy infestation would lead to anemia when unchecked. The frequent and rapid feeding intervals result in numerous painful bites on the host, prompting the host to scratch against rough surfaces. The scratches lead to the development of wounds, creating a conducive environment for myiasis, a condition where larvae infest the host's wounds.  The occurrence of myiasis adds to the economic burden for farmers, as it results in increased production costs and substantial losses when livestock succumb to the negative effects of this infestation.

The control strategies of vector-borne diseases (VBDs) and their effects target the vector itself, thereby controlling the transmission rates of the vectored pathogens. Most vectors, particularly Dipterans or Insects, have developed a robust chemosensory system that plays a vital role in their ability to locate hosts for feeding, mates for reproduction, and predator evasion, which ultimately contributes to their successful establishment ecologically. To effectively suppress pathogen transmission to hosts, strategies have been devised to exploit the vector's chemosensory system in order to trap and repel the vectors themselves. 

In this study, we hypothesize that Hippoboscus, a dipteran, relies extensively on its chemosensory system to locate its host, facilitate reproduction, and potentially transmit pathogens.
A genome assembly for the *Hippobosca* species is currently unavailable in the genome database. This limits access to molecular insights on Hippobosca species, particularly the chemosensory system.

This study therefore focused on generating a whole genome assembly for two *Hippobosca* species: *Hippobosca variegata* and *Hippobosca camelina* and describing their chemosensory system. 


![Screenshot from 2023-08-27 15-24-57](https://github.com/fredrickkebaso/Hipposcus_Genome_Assembly_And_Annotation/assets/60787991/412b2f9d-2df1-4f7c-8665-e084f470099c)

***H.camelina***; Adapted from ICIPE Insect of the month, photo by Dr. Dan Masiga.; ***H.variegata*** - Adapted from Namibia discussion forum.


The availing of the genome assembly will provide the knowledge base upon which vector competence, epidemiology and effective control strategies of the hippoboscus flies will be based. 

## Study Objectives

### Overall objective 
- To construct a whole genome assembly of *H. variegata* and *H. camelina* and describe the genes responsible for chemosensing in *Hippobosca.*

### Specific objectives

1. To generate whole genome assembly for *H. variegata* and *H. camelina*.

2. To identify the genomic architecture and gene content of the chemosensory genes in the three *Hippobosca* species.


## Analysis workflow

### De novo genome assembly workflow

![Workflows-De-novo assembly drawio ](https://github.com/fredrickkebaso/Hipposcus_Genome_Assembly_And_Annotation/assets/60787991/5329bae0-b649-4234-a015-4f8bea4ebff2)


### Functional annotation Workflow

![Workflows-Functional annotation drawio](https://github.com/fredrickkebaso/Hipposcus_Genome_Assembly_And_Annotation/assets/60787991/8094ff09-8587-447d-8a37-d9463a120cfb)





## Software and Packages

All tools used have been documented [here](https://github.com/fredrickkebaso/Hipposcus_Genome_Assembly_And_Annotation/blob/main/software%20packages%20.md)

## Results

### Objective 1. Assembled Genome Features


| Metric | *Hippoboscus variegata* | *Hippoboscus camelina* |
|--------|-----------------------|----------------------|
| **Genome size (mb)** | 147.25 | 148.44 |
| **Contig N50 (kb)** | 3kb | 3kb |
| **Number of contigs** | 177664 | 179543 |
| **GC content**| 29.40% | 28.60% |
| **Percentage gaps** | 0.74% | 0.08% |

**Table Showing the genome quality metrics for each of the Hippoboscus species.** 
*The metric column represents the genome attribute, and the Hippoboscus variegata and Hippoboscus camelina column shows the genome score per feature.* 


### Objective 2. Chemosensory genes annotated for *Hippoboscus* Species


### Sample predicted Gustatory Receptor for _H. cameina_.


![H camelina_Gustatory_receptor](https://github.com/fredrickkebaso/Hipposcus_Genome_Assembly_And_Annotation/assets/60787991/9a32c9f9-2630-4adc-82a8-12c22ebf15a3)

**Figure 1:  Positions of the transmembrane domains of the predicted Putative Gustatory receptor of _Hippobosca camelina_.** The numerical values ranging from 1 to 5 correspond to the existing domains. The horizontal bar symbolizes the cellular membrane.


![hippoboscus_only_chem_genes](https://github.com/fredrickkebaso/Hipposcus_Genome_Assembly_And_Annotation/assets/60787991/bed7d50e-7901-48d3-b83b-932d9a1bd1dc)

**Figure 2: A group bar chart showing the predicted chemosensory gene counts per gene familly in _H. variegata_ and _H.**  camelina_ gene counts. The Y-axis shows the actual gene counts per gene family. The X-axis shows the gene family; Chemosensory Specific Proteins (CSPs), Gustatory Proteins(GRs), Ionotropic Receptors (IRs), Odorant Binding Proteins (OBPs), and Odorant Receptors (ORs).


![chemosensory_genes_hippoboscus_vs_Glossina](https://github.com/fredrickkebaso/Hipposcus_Genome_Assembly_And_Annotation/assets/60787991/d604256d-33f3-4c3f-88cf-99bf347e72b3)

**Figure 3: A group bar chart showing the predicted chemosensory gene counts per gene familly in _H. variegata_ and _H.  camelina_ alongside _Glossina morsitans _gene counts.** The Y-axis shows the actual gene counts per gene family. The X-axis shows the gene family; Chemosensory Specific Proteins (CSPs), Gustatory Proteins(GRs), Ionotropic Receptors (IRs), Odorant Binding Proteins (OBPs), and Odorant Receptors (ORs).





