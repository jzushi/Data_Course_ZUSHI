library(tidyverse)
path <- "~/Desktop/Data_Course_ZUSHI/Final_Project"
list.files("~/Desktop/Data_Course_ZUSHI/Final_Project/Halophila_mycobiome/fwd/")
fnFs <- sort(list.files("~/Desktop/Data_Course_ZUSHI/Final_Project/Halophila_mycobiome/fwd/", pattern=".fastq", full.names = TRUE))
sample.names <- sapply(strsplit(basename(fnFs), "_"), `[`, 1)
plotQualityProfile(fnFs[1:2])
