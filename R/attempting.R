
ebRNA <- read.table(file="data/GSE109262_EB_RNA_counts.txt", header=TRUE, sep="\t", quote="", row.names=1)
escRNA <- read.table(file="data/GSE109262_ESC_RNA_counts.txt", header=TRUE, sep="\t", quote="", row.names=1)
dim(ebRNA)
dim(escRNA)

ensGenes <- rownames(ebRNA)

library(biomaRt)


ensembl <- useMart("ensembl", host="http://dec2016.archive.ensembl.org/") ## using mm9
ensembl = useDataset("mmusculus_gene_ensembl", mart=ensembl)
attrs <- listAttributes(ensembl)
head(attrs, 20)
map <- getBM(mart=ensembl, attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id"))
#            filters="ensembl_gene_id", values=ensGenes)

idx <- which(ensGenes %in% map$ensembl_gene_id)

length(idx)
length(ensGenes)

library(SingleCellExperiment)
colnames(map) <- c("chr", "start", "end", "ENSEMBLID")

rowranges <- makeGRangesFromDataFrame(df=map[idx,])

rowranges$ENSEMBLID <- map$ENSEMBLID[idx]

cc <- cbind(ebRNA, escRNA)

library(GEOquery)
gds <- getGEO("GSE109262")
gds
sampnames <- gds$`GSE109262-GPL13112_series_matrix.txt.gz`$title

idx <- which(gsub("_NOMe-seq", "", gsub("_RNA-seq", "", sampnames)) %in% colnames(cc))
coldata <- as.data.frame(gds$`GSE109262-GPL13112_series_matrix.txt.gz`)[idx,]

duplicated(gsub("_NOMe-seq", "", gsub("_RNA-seq", "", coldata$title)))

## to build the colData check better the gds of GEO


scc <- SingleCellExperiment(assays=list(counts=as.matrix(cc)), rowRanges=rowranges)#, colData=coldata)

mae <- MultiAssayExperiment::MultiAssayExperiment(experiments=list(sce1=scc,sce2=scc))



