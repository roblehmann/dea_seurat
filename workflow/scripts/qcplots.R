#### load libraries & utility function 
library(Seurat)
library(ggplot2)

# inputs
object_path <- snakemake@input[[1]] #"/nobackup/lab_bock/projects/macroIC/results/AKsmall/scrnaseq_processing_seurat/KOcall_NonTargeting/NORMALIZED_object.rds"

# outputs
dea_result_path <- snakemake@output[["dea_qcplots"]] 

snakemake@source("./utils.R")

# parameters
assay <- snakemake@params[["assay"]] #"SCT" #"RNA"
metadata <- snakemake@params[["metadata"]] #"condition"
control <- snakemake@params[["control"]] #"untreated"

### load data
data <- readRDS(file = file.path(object_path))
DefaultAssay(object = data) <- assay
Idents(object = data) <- metadata

## adding percent -MT column
data[["percent.mt"]] <- PercentageFeatureSet(data, pattern = "^MT-")
vln<-VlnPlot(data, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
# FeatureScatter is typically used to visualize feature-feature relationships, but can be used
# for anything calculated by the object, i.e. columns in object metadata, PC scores etc.

plot1 <- FeatureScatter(data, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(data, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
scatterplt<- plot1 + plot2
final<-scatterplt/vln

ggsave_new(filename = "DEA_qcplot",
           results_path = dirname(dea_result_path),
           plot=final, 
           width = 8, 
           height = 5 )
