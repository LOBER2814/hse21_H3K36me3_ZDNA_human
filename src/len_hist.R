
source('lib.R')

###

#NAME <- 'H3K36me3_K562.ENCFF903ZMQ.hg19'
#NAME <- 'H3K36me3_K562.ENCFF903ZMQ.hg38'
#NAME <- 'H3K36me3_K562.ENCFF901ACN.hg19'
#NAME <- 'H3K36me3_K562.ENCFF901ACN.hg38'
NAME <- 'zhunt'

###

bed_df <- read.delim(paste0(DATA_DIR, NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start
#head(bed_df)


ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.init.hist.pdf'), path = OUT_DIR)


bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 2000)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.filtered.hist.pdf'), path = OUT_DIR)


bed_df %>%
  select(-len) %>%
  write.table(file=paste0(DATA_DIR, NAME, '.filtered.bed'),
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)


