# Load packages
library(vegan)
library(tidyverse)
library(phyloseq)
library(dada2); packageVersion("dada2")
library(purrr)
library(tidyr)
library(ggplot2)
library(readxl)
library(plyr)

## Loaded and played around with data
ps <- readRDS("../Back_up_Halophila_mycobiome/phyloseq_output.RDS")
ps
ntaxa(ps)
nsamples(ps)
sample_names(ps)[1:10]
taxa_names(ps)[1:10]
sample_variables(ps)[1:10]
length(sample_variables(ps))
get_variable(ps, sample_variables(ps)[5])[1:10]
rank_names(ps)
get_taxa_unique(ps, "Phylum")
colnames(tax_table(ps)) <- c(k = "Kingdom", p = "Phylum", c = "Class", 
                                  o = "Order", f = "Family", g = "Genus", s = "Species")

sample_sums(ps)[1:10]
taxa_sums(ps)[1:10]
get_taxa(ps, sample_names(ps)[5])[1:10]
get_sample(ps, taxa_names(ps)[5])[1:10]

plot_richness(ps,measures="Shannon",color="Country")

## removed blanks from samples
ps2 = subset_samples(ps,Location != "Blank")

## removed everything that wasn't in k__Fungi
ps3 = subset_taxa(ps2, Kingdom == "k__Fungi")

## removed NA from phylum
ps4 = subset_taxa(ps3, Phylum != "NA")

## removed NA from genus
ps5 = subset_taxa(ps4, Genus != "NA")

## plotted richness
ps6 = plot_richness(ps5,measures="Shannon",color="Country")


ps6 + geom_boxplot(data = ps6$data, aes(x = "Samples", y = value, color = NULL), alpha = 0.1)


## abundance bar plots
TopNOTUs = names(sort(taxa_sums(ps5), TRUE)[1:10])
ent10 = prune_taxa(TopNOTUs, ps5)
plot_bar(ent10, "Phylum", fill = "Location", facet_grid = Phylum ~ Genus)

plot_bar(ent10, "Genus", fill = "Location", facet_grid = Phylum ~ Location)

plot_bar(ent10, "Abundance", fill = "Location", facet_grid = Phylum ~ Location)

plot_bar(ps5, x="Genus", y="Abundance", fill=NULL)

## Preprocessing abundance data

# prune OTUs that are not present in at least one sample
PS = prune_taxa(taxa_sums(ps5) > 0, ps5)

## prune_taxa() vs. subset_taxa()
topN = 20
most_abundant_taxa = sort(taxa_sums(ps5), TRUE)[1:topN]
print(most_abundant_taxa)

PS20 = prune_taxa(names(most_abundant_taxa), ps5)

ntaxa(PS20)

length(get_taxa_unique(PS20, "Phylum"))

PS.asc = subset_taxa(ps5, Phylum == "p__Ascomycota")

ntaxa(PS.asc)


PS.bas = subset_taxa(ps5, Phylum == "p__Basidiomycota")


ntaxa(PS.bas)

length(get_taxa_unique(PS.asc, "Phylum"))

length(get_taxa_unique(PS.bas, "Phylum"))


## filterfun_sample() and genefilter_sample()
topp(0.1)
f1 = filterfun_sample(topp(0.1))
print(f1)

wh1 = genefilter_sample(ps5, f1, A = round(0.5 * nsamples(ps5)))
sum(wh1)

ex2 = prune_taxa(wh1, ps5)
print(ps5)
print(ex2)

## Filtering low-variance OTUs
GPr = transform_sample_counts(ps5, function(x) x/sum(x))


## Graphics for Inference and Exploration
ps5
GP = subset_taxa(ps5,taxa_sums(ps5)>0)
GP = subset_taxa(ps5,taxa_sums(ps5)!="NA")
GP = subset_samples(ps5,sample_sums(ps5)!="NA")
GP = subset_samples(ps5,sample_sums(ps5)>0)


top5ph = sort(tapply(taxa_sums(GP), tax_table(GP)[, "Phylum"], sum), TRUE)[1:5]

# Network plotting
dist.test = distance(GP, method = "jaccard")
plot(dist.test)
ig = make_network(GP, method = "jaccard", max.dist = 0.85)
plot_network(ig, physeq = GP, color = "Location", shape = "Source", line_weight = 0.4)
ggsave("../Back_up_Halophila_mycobiome/network1.png", dpi = 300)

# Using top 100
GP100 = prune_taxa(names(sort(taxa_sums(GP)>0, TRUE))[1:100], GP)
GP100 = prune_taxa(names(sort(taxa_sums(GP)!="NA", TRUE))[1:100], GP)
GP100 = prune_samples(names(sort(sample_sums(GP)>0, TRUE))[1:100], GP)
GP100 = prune_samples(names(sort(sample_sums(GP)!="NA", TRUE))[1:100], GP)
jg = make_network(GP100, max.dist = 0.7)

plot_network(jg, physeq = GP100, color = "Location", shape = "Source", line_weight = 0.4, label = NULL)
ggsave("../Back_up_Halophila_mycobiome/networktop100.png", dpi = 300)

# Principal Components Analysis
pc_matrix = (decostand(otu_table(GP), method = "total", MARGIN = 1))
rowSums(pc_matrix)
summary(colSums(pc_matrix))
good.cols = which(colSums(pc_matrix) > 0)
pc_matrix = pc_matrix[,good.cols]


pc <- prcomp(pc_matrix ,scale. = TRUE, center = TRUE)
plot_ordination(GP, pc, color= "Location") + lims(x=c(-10,10),y=c(-10,10))


# Merged by source and location 
variable1 = as.character(get_variable(GP, "Source"))
variable2 = as.character(get_variable(GP, "Location"))
sample_data(GP)$NewPastedVar <- mapply(paste, variable1, variable2, collapse = "_", sep = "_")
GP.M = merge_samples(GP, "NewPastedVar")

source2 = unique(sample_data(GP)$Source)
location2 = unique(sample_data(GP)$Location)

# Repaired values of source and location
GP.M@sam_data$Source = rep(source2,each=7)
location2 = location2[c(4,1,3,5,7,6,2)]
GP.M@sam_data$Location = rep(location2,4)
sample_data(GP.M)


# Cleaned up new zeroes
GP.M <- prune_samples(sample_sums(GP.M) != 0, GP.M)

# convert to relabund
GP.M = transformSampleCounts(GP.M, function(OTU) OTU/sum(OTU))

# Edit taxon names
GP.M@tax_table@.Data[,"Phylum"] <- as.character(gsub("p__","",GP.M@tax_table@.Data[,"Phylum"]))
GP.M@tax_table@.Data[,"Class"] <- as.character(gsub("c__","",GP.M@tax_table@.Data[,"Class"]))


# Bar plot
plot_bar(GP.M, fill = "Class", x= "Location") + facet_grid(~Source)
ggsave("../Back_up_Halophila_mycobiome/enhalus_phylum_barplot.png", dpi = 300)





