library(vegan)
library(tidyverse)
library(phyloseq)
library(dada2); packageVersion("dada2")
library(purrr)
library(tidyr)
library(ggplot2)
library(readxl)

## Played around with data
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
# Exploratory tree #1 (Note, too ma) plot_tree(ex2, color='SampleType',
# label.tips='Family', size='abundance')
ntaxa(PS20)

length(get_taxa_unique(PS20, "Phylum"))

PS.asc = subset_taxa(ps5, Phylum == "p__Ascomycota")
# Exploratory tree #2 plot_tree(PS.asc, color='SampleType', shape='Family',
# label.tips='Genus', size='abundance')
ntaxa(PS.asc)


PS.bas = subset_taxa(ps5, Phylum == "p__Basidiomycota")
# Exploratory tree #2 plot_tree(PS.bas, color='SampleType', shape='Family',
# label.tips='Genus', size='abundance')
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
# GPf = filter_taxa(GPr, function(x) var(x) > 1e-05, TRUE)

###################################################

## examples that Zahn used

# 
plot_bar(ps3,fill="Location")
# 
# subset_samples(ps, Location == "Cyrene")
# 
# tax_table(subset_taxa(ps, Kingdom == "k__Rhizaria"))
# table(tax_table(ps)[,2])
# 
# 
# meta$Country
# 
# 
# ps.ra = transform_sample_counts(ps, function(x) x/sum(x))
# ord = ordinate(ps, method = "NMDS")
# plot_ordination(ps,ord,color="Location")
# 
# 
# plot_bar(ps.ra, fill = "Phylum")



