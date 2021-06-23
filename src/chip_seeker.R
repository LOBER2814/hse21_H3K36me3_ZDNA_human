
source('lib.R')

###

library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(clusterProfiler)
library(org.Hs.eg.db)
###


NAME <- 'H3K36me3_K562.ENCFF903ZMQ.hg19.filtered'
#NAME <- 'H3K36me3_K562.ENCFF901ACN.hg19.filtered'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')

###

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
#png(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()


###

peak <- readPeakFile(BED_FN)
pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
covplot(peak, weightCol="V5")
dev.off()