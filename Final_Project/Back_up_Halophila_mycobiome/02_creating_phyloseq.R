
# Load Packages
library(dada2); packageVersion("dada2")
library(purrr)
library(tidyr)
library(ggplot2)
library(readxl)
library(phyloseq)

# Load data 
taxa = readRDS("../Back_up_Halophila_mycobiome/seqtab_w_taxa.RDS")
taxa.print = taxa
meta = read.csv("../../Final_Project/Back_up_Halophila_mycobiome/sample_mapping_data.csv",stringsAsFactors = FALSE)
str(meta)
seqtab.nochim = readRDS("../../Final_Project/Back_up_Halophila_mycobiome/seqtab.nochim.rds")

# Evaluated to see if our matrix match
sum(dimnames(seqtab.nochim)[[1]] %in% meta$IlluminaName)

unique(dimnames(seqtab.nochim)[[1]])
unique(meta$IlluminaName)

# Look at Halophila ovalis and Blank data
sum(meta$Species == "Halophila ovalis")
sum(meta$Species == "Blank")

# Viewed everything
row.names(df)
head(df)[[1]]

# compared identical damples
identical(row.names(seqtab.nochim), meta$SampleID)
dim(taxa)
dim(seqtab.nochim)
dim(meta)

samps = row.names(seqtab.nochim)
meta = meta[meta$IlluminaName %in% samps,]
row.names(meta) = meta$IlluminaName

# create an otu_table, tax_table, and meta variable
otu = otu_table(seqtab.nochim, taxa_are_rows = FALSE)
tax = tax_table(taxa)
meta.ps = sample_data(meta)

# Create phyloseq
ps <- phyloseq(otu, meta.ps, tax)

## Save code checkpoing for phyloseq object
saveRDS(ps, "../Back_up_Halophila_mycobiome/phyloseq_output.RDS")

#####################################################




