This is a scratch repository for creating a MultiAssayExperiment for data integration to give public accessibility to it through bioconductor.

first attempt is based on the following dataset:
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=gse109262

associated to the following paper:
https://www.nature.com/articles/s41467-018-03149-4

Here is a template package, although it is more complicated. Not all is relevant, just the functions for accessing whole studies: https://github.com/waldronlab/cBioPortalData. 
* [R/downloadStudy.R](https://github.com/waldronlab/cBioPortalData/blob/master/R/downloadStudy.R) demonstrates use of BiocFileCache to download and cache data
* [R/cBioDataPack.R](https://github.com/waldronlab/cBioPortalData/blob/master/R/cBioDataPack.R) demonstrates user-facing request and assembly of MultiAssayExperiment

