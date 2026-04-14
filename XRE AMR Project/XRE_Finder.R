# If running for first time install BiocManager and install packages using BioManager
# BiocManager will download the dependencies and makes it a bit easier

# intall.packages('BiocManager')
# then run: 
# BiocManager::install('biomartr')
# BiocManager::install('Biostrings')
# BiocManager::install('GenomicFeatures')

library(biomaRtr)
library(Biostrings)
library(GenomicFeatures)

# Use this to check for genome in refseq for your genome and it'll download it. 
# Since this is for bacteria is had to set skip_bacter to False because you'll just download everything you don't need. 

# just realized, there's a better way to check and I'll update that in a bit. 

PA_genome = getGenome(
  db = "refseq",
  "Pseudomonas aeruginosa",
  reference = TRUE,
  skip_bacteria = FALSE
)

# GFF file so I can find the promotors
PA_gff = getGFF(db = 'refseq',
                organism = 'Pseudomonas aeruginosa',
                reference = TRUE)

#// Processing Time

# string it
PA_dna = readDNAStringSet(PA_genome)
# had some trouble, and this might help fix it
names(PA_dna) = sub(" .*$", "", names(PA_dna))

# This turns the text file into a searchable database of gene coordinates
txtPAgenome = makeTxDbFromGFF(PA_gff)
allGenes = genes(txtPAgenome)
single_chrom <- PA_dna[[1]]

# Idea - for these last 3 steps, I bet we could make htis a single function... 

# We define "promoter" as 200bp upstream and 50bp downstream of the start site
# 'upstream' looks at the strand (+ or -) and moves in the correct direction automatically!
# double check this suggested logic, I'm not 100% I understand the reasoning - could be convention
promoter_seqs = promoters(allGenes, upstream = 200, downstream = 50)

# trim the excess sequences
promotor_seq = trim(promoter_seqs)

# now we can get the DNA sequences for the promoters:
final_promotors_dna = getSeq(single_chrom, promoter_seq)

  