
# Uniprot query to obtain chemosensory protein sequence
-------------------------------------------------------

This are queries used to mine chemosensory protein sequences for different gene famillies from uniprot database

**Instructions**

create directories for the different gene famillies

```
mkdir -p data/prot_database/{chemosensory_CSPs,gustatory_GRs,ionotropic_IRs,odorant_OBPs,odorant_ORs,sensory_SNMPs}
```

Each gene familly sequences should be downloaded to their corresponding directories. 


### 1) Odorant binding proteins (OBPs)
--------------------------------------

**Query :**  

```
(protein_name: "odorant binding protein") AND ("Drosophila melanogaster" OR "Anopheles gambiae" OR Glossina OR "Musca domestica" OR "Ceratitis capitata")
```

OR 

**API URL using the streaming endpoint**

This endpoint is resource-heavy but will return all requested results.

[API URL Download Link](https://rest.uniprot.org/uniprotkb/stream?compressed=true&format=fasta&query=%28%28protein_name%3A%20%22odorant%20binding%20protein%22%29%20AND%20%28%22Drosophila%20melanogaster%22%20OR%20%22Anopheles%20gambiae%22%20OR%20Glossina%20OR%20%22Musca%20domestica%22%20OR%20%22Ceratitis%20capitata%22%29%29)


### 2) Chemosensory protein (CSPs)
----------------------------------

**Query :**

```
(protein_name: "chemosensory protein") AND ("Drosophila melanogaster" OR "Anopheles gambiae" OR Glossina OR "Musca domestica" OR "Ceratitis capitata")
```
OR

**API URL using the streaming endpoint**

This endpoint is resource-heavy but will return all requested results.

[API URL Download Link](https://rest.uniprot.org/uniprotkb/stream?compressed=true&format=fasta&query=%28%28protein_name%3A%20%22chemosensory%20protein%22%29%20AND%20%28%22Drosophila%20melanogaster%22%20OR%20%22Anopheles%20gambiae%22%20OR%20Glossina%20OR%20%22Musca%20domestica%22%20OR%20%22Ceratitis%20capitata%22%29%29)


### 3)Sensory Neuron Membrane proteins (SNMPs)
----------------------------------------------

**Query :**

```
(protein_name: "Sensory Neuron Membrane protein") AND ("Drosophila melanogaster" OR "Anopheles gambiae" OR Glossina OR "Musca domestica" OR "Ceratitis capitata")
```
OR
**API URL using the streaming endpoint**

This endpoint is resource-heavy but will return all requested results.

[API URL Download Link](https://rest.uniprot.org/uniprotkb/stream?compressed=true&format=fasta&query=%28%28protein_name%3A%20%22Sensory%20Neuron%20Membrane%20protein%22%29%20AND%20%28%22Drosophila%20melanogaster%22%20OR%20%22Anopheles%20gambiae%22%20OR%20Glossina%20OR%20%22Musca%20domestica%22%20OR%20%22Ceratitis%20capitata%22%29%29)


### 4) Gustatory Receptors (GRs)
--------------------------------

**Query :**

```
(protein_name: "gustatory receptor") AND ("Drosophila melanogaster" OR "Anopheles gambiae" OR Glossina OR "Musca domestica" OR "Ceratitis capitata")
```
OR
**API URL using the streaming endpoint**

This endpoint is resource-heavy but will return all requested results.

[API URL Download Link](https://rest.uniprot.org/uniprotkb/stream?compressed=true&format=fasta&query=%28%28protein_name%3A%20%22gustatory%20receptor%22%29%20AND%20%28%22Drosophila%20melanogaster%22%20OR%20%22Anopheles%20gambiae%22%20OR%20Glossina%20OR%20%22Musca%20domestica%22%20OR%20%22Ceratitis%20capitata%22%29%29)


### 5) ionotropic receptor and ionotropic glutamate receptor (IRs)
------------------------------------------------------------------

**Query :**

```
(protein_name: "ionotropic glutamate receptor " OR "ionotropic receptor") AND ("Drosophila melanogaster" OR "Anopheles gambiae" OR Glossina OR "Musca domestica" OR "Ceratitis capitata")
```
OR
**API URL using the streaming endpoint**

This endpoint is resource-heavy but will return all requested results.

[API URL Download Link](https://rest.uniprot.org/uniprotkb/stream?compressed=true&format=fasta&query=%28%28protein_name%3A%20%22ionotropic%20glutamate%20receptor%20%22%20OR%20%22ionotropic%20receptor%22%29%20AND%20%28%22Drosophila%20melanogaster%22%20OR%20%22Anopheles%20gambiae%22%20OR%20Glossina%20OR%20%22Musca%20domestica%22%20OR%20%22Ceratitis%20capitata%22%29%29)


### 6) odorant receptors (ORs)
------------------------------

**Query :**

```
(protein_name: "odorant receptor ") AND ("Drosophila melanogaster" OR "Anopheles gambiae" OR Glossina OR "Musca domestica" OR "Ceratitis capitata")
```
OR
**API URL using the streaming endpoint**

This endpoint is resource-heavy but will return all requested results.

[API URL Download Link](https://rest.uniprot.org/uniprotkb/stream?compressed=true&format=fasta&query=%28%28protein_name%3A%20%22odorant%20receptor%20%22%29%20AND%20%28%22Drosophila%20melanogaster%22%20OR%20%22Anopheles%20gambiae%22%20OR%20Glossina%20OR%20%22Musca%20domestica%22%20OR%20%22Ceratitis%20capitata%22%29%29)


---------------------------------------------------------------------COMPLETED---------------------------------------------------------------------------



