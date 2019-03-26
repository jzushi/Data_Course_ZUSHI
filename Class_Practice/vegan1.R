library(tidyverse)
library(vegan)
library(phyloseq)

# load data
meta <- read.csv("../Data_Course/Data/MLO_Metadata.csv")
otu <- read.csv("../Data_Course/Data/MLO_OTU_Table.csv")




# fix row names
colnames(otu)[1] <- "sample"
row.names(otu) <- otu$sample
otu <- otu[,-1] #equals all rows, not 1

# subset metadata to same samples that are in otu and then make sure they're in the exact same order
good.samples <- as.character(meta$SampleID) %in% row.names(otu)
sum(good.samples)
meta <- meta[good.samples,]
meta <- arrange(meta, SampleID)


# sanity test
identical(row.names(otu), as.character(meta$SampleID))



# remove empty otus
colSums(otu)
otu <- otu[colSums(otu) > 0]

# remove empty samples
rowSums(otu)
otu <- otu[rowSums(otu) > 0,]

# quick heatmap
heatmap(as.matrix(otu))


# subset metadata to same samples that are in otu and then make sure they're in the exact same order
good.samples <- as.character(meta$SampleID) %in% row.names(otu)
sum(good.samples)
meta <- meta[good.samples,]
meta <- arrange(meta, SampleID)

# quick heatmap
heatmap(as.matrix(otu))

# building a model... community structure as function of year

dist <- vegdist(otu, method = "jaccard", binary = TRUE)
adonis(dist ~ meta$Year + meta$Quarter)


# visualize it
nmds <- metaMDS(otu)
x <- nmds$points[,1]
y <- nmds$points[,2]

df <- data.frame(Quarter = meta$Quarter, Year = meta$Year, x = x, y = y)

ggplot(df, aes(x = x, y = y, color = factor(Year))) +
  geom_point() +
  lims(x = c(-.1,.1))





