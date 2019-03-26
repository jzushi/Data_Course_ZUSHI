library(dada2); packageVersion("dada2")
library(purrr)
library(tidyr)
library(ggplot2)
library(readxl)
library(phyloseq)

taxa = readRDS("../Back_up_Halophila_mycobiome/seqtab_w_taxa.RDS")
taxa.print = taxa
meta = read.csv("../../Final_Project/Back_up_Halophila_mycobiome/sample_mapping_data.csv",stringsAsFactors = FALSE)
str(meta)

# meta = meta[order(meta$SampleID),]
# row.names(meta) <- meta$SampleID


## I changed this to the seqtab.nochim.rds to see if it would work but maybe I should ty to go back to seqtab_w_taxa.rds?
seqtab.nochim = readRDS("../../Final_Project/Back_up_Halophila_mycobiome/seqtab.nochim.rds")


# df = as.data.frame(seqtab.nochim, row.names = 1)
# row.names(df) <- meta$SampleID
# length(meta$SampleID)
# length(row.names(df))

sum(dimnames(seqtab.nochim)[[1]] %in% meta$IlluminaName)


unique(dimnames(seqtab.nochim)[[1]])
unique(meta$IlluminaName)

sum(meta$Species == "Halophila ovalis")
sum(meta$Species == "Blank")




row.names(df)
head(df)[[1]]



identical(row.names(seqtab.nochim), meta$SampleID)
dim(taxa)
dim(seqtab.nochim)
dim(meta)

ps <- phyloseq(otu_table(seqtab.nochim, taxa_are_rows=FALSE), 
               sample_data(meta), 
               tax_table(taxa))

saveRDS(ps, "../Back_up_Halophila_mycobiome/phyloseq_output.RDS")

contamdf.prev <- isContaminant(ps, neg=c(325:327), threshold = 0.1)
table(contamdf.prev$contaminant)
