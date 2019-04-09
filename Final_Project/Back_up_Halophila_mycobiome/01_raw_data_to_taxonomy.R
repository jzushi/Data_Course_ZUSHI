
# Load Packages
library(tidyverse)
library(BiocManager)
library(ShortRead)
library(dada2)

# Load data 
files <- readFastq(path, pattern = "fastq.gz")
path <- "~/Desktop/Data_Course_ZUSHI/Final_Project/Back_up_Halophila_mycobiome/fwd"
list.files(path)

# Read in the names of the fastq files and rename to fnFs only forward reads were part of this data
fnFs <- sort(list.files(path, pattern=".fastq.gz", full.names = TRUE))

# String manipulate to get matched lists of the forward fastqfiles
sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)

# Inspect read quality profiles
plotQualityProfile(fnFs[1:2])

# Filter and trim 
filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))


out = filterAndTrim(fnFs, filtFs,
                    maxN=0, maxEE=2, truncQ=2, rm.phix=TRUE, compress = TRUE, multithread=2) 
head(out)

# Learn the error rates
errF <- learnErrors(filtFs, multithread=TRUE)

# Sanity check to visualize the error rates
plotErrors(errF, nominalQ=TRUE)

# Derepilcated sequences
derepFs <- derepFastq(filtFs, verbose=TRUE)
names(derepFs) <- sample.names

# Sample inference
dadaFs <- dada(derepFs, err=errF, multithread=TRUE)

# Construct sequence table
seqtab <- makeSequenceTable(dadaFs)
dim(seqtab)

## Save code for check point ##
saveRDS(seqtab, file = "halo_seqtab.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)

# Inspect distribution of sequence lengths
table(nchar(getSequences(seqtab)))

# Remove chimeras
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=TRUE, verbose=TRUE)
dim(seqtab.nochim)

## Save code for checkpoing ##
saveRDS(seqtab.nochim, file = "halo_nochim.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)


# Track reads through pipeline
getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN),  rowSums(seqtab.nochim))

colnames(track) <- c("input", "filtered", "denoisedF",  "nonchim")
rownames(track) <- sample.names
head(track)
track = as.data.frame(track)


# remove short seqs
shorties = which(nchar(getSequences(seqtab.nochim)) < 51)
seqtab.nochim = seqtab.nochim[,-shorties]

saveRDS(seqtab.nochim, file = "seqtab.nochim.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)



# Assign taxonomy
## Vector memory too full for this code, will have to push and do on an actual computer instead of laptop

###### What Geoff did on his computer #######
seqtab.nochim = readRDS("seqtab.nochim.rds")
taxa <- assignTaxonomy(seqtab.nochim, "UNITE_anthozoa_enhalus_halophila.fasta copy.gz", multithread = TRUE)
saveRDS(taxa, "seqtab_w_taxa.RDS")

#############################################

