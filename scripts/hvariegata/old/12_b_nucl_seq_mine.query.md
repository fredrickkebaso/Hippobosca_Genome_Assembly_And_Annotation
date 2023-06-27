# Search strategy to mine chemosensory nucleotide sequences from VectorBase
-------------------------------------------------------

These are queries used to mine chemosensory protein sequences for different gene famillies from VectorBase database.

**Instructions**

create directories for the different gene famillies

```
mkdir -p data/nucl_database/{chemosensory_CSPs,gustatory_GRs,ionotropic_IRs,odorant_OBPs,odorant_ORs,sensory_SNMPs}
```

Each gene familly sequences should be downloaded to their corresponding directories. 


### 1) Odorant binding proteins (OBPs)
--------------------------------------

**Query :**  
Text term: "Odorant binding protein" 
Organism :[Drosophila,Anopheles,Glossina,Musca,Aedes]

### 2) Chemosensory protein (CSPs)
----------------------------------

**Query :**
Text term: "Chemosensory protein" 

Organism :[Drosophila,Anopheles,Glossina,Musca,Aedes]

### 3)Sensory Neuron Membrane proteins (SNMPs)
----------------------------------------------

**Query :**
Text term: "Sensory neuron membrane protein" 

Organism :[Drosophila,Anopheles,Glossina,Musca,Aedes]


### 4) Gustatory Receptors (GRs)
--------------------------------

**Query :**

Text term: "Gustatory Receptor" 

Organism :[Drosophila,Anopheles,Glossina,Musca,Aedes]


### 5) ionotropic receptor and ionotropic glutamate receptor (IRs)

------------------------------------------------------------------

**Query :**

Text term: "ionotropic receptor" OR "ionotropic glutamate receptor"

Organism :[Drosophila,Anopheles,Glossina,Musca,Aedes]

### 6) odorant receptors (ORs)
------------------------------

**Query :**

Text term: "odorant receptor"

Organism :[Drosophila,Anopheles,Glossina,Musca,Aedes]





