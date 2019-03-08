library(tidyverse)
library(BiocManager)
library(ShortRead)
library(dada2)
files <- readFastq(path, pattern = "fastq.gz")
path <- "~/Desktop/Data_Course_ZUSHI/Final_Project/Back_up_Halophila_mycobiome/fwd"
list.files(path)
fnFs <- sort(list.files(path, pattern=".fastq.gz", full.names = TRUE))
sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
plotQualityProfile(fnFs[1:2])

filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))

#Once I am done with the tutorial, I may want to go back here and out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=c(240,160),
#maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
#compress=TRUE, multithread=TRUE) # On Windows set multithread=FALSE
#head(out)



out = filterAndTrim(fnFs, filtFs,
                    maxN=0, maxEE=2, truncQ=2, rm.phix=TRUE, compress = TRUE, multithread=2) 
head(out)

errF <- learnErrors(filtFs, multithread=TRUE)


plotErrors(errF, nominalQ=TRUE)

derepFs <- derepFastq(filtFs, verbose=TRUE)
names(derepFs) <- sample.names
dadaFs <- dada(derepFs, err=errF, multithread=TRUE)
# mergers <-c(dadaFs, derepFs)
seqtab <- makeSequenceTable(dadaFs)
dim(seqtab)

saveRDS(seqtab, file = "halo_seqtab.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)
#df <- readRDS("halo_seqtab.rds")
table(nchar(getSequences(seqtab)))

seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=TRUE, verbose=TRUE)
dim(seqtab.nochim)
saveRDS(seqtab.nochim, file = "halo_nochim.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)

#df2 <- readRDS("halo_nochim.rds")

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

#vector memory too full for this code, will have to push and do on an actual computer
#df3 <- assignTaxonomy(seqtab.nochim, "../Halophila_mycobiome/halo_raw_data.rds", multithread = TRUE)
#once done will readRDS
#then use phyloseek tutorials



