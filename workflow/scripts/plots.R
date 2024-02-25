#### load libraries & utility function 
library(Seurat)

# source utility functions
# source("workflow/scripts/utils.R")
snakemake@source("./utils.R")

# inputs
object_path <- snakemake@input[[1]] #"/nobackup/lab_bock/projects/macroIC/results/AKsmall/scrnaseq_processing_seurat/KOcall_NonTargeting/NORMALIZED_object.rds"

# outputs
plots_path <- snakemake@output[["plots"]] #"/nobackup/lab_bock/projects/macroIC/results/AKsmall/dea_seurat/KOcall_NonTargeting_condition/DEA_results.csv" 

### load data
data <- readRDS(file = file.path(object_path))
DefaultAssay(object = data) <- assay
Idents(object = data) <- metadata

# Run non-linear dimensional reduction
# Run UMAP
your_seurat_object <- RunUMAP(data, dims = 1:10)

# Plot UMAP
umap_plot <- DimPlot(data, dims=c(1,2), reduction = "umap", group.by = "seurat_clusters", label = TRUE, label.size = 2.5, repel = TRUE) + ggtitle("UMAP")

# save plot
ggsave_new(filename = "UMAP_plot", 
           results_path=dirname(plots_path), 
           plot=umap_plot)

# Run tSNE
your_seurat_object <- RunTSNE(data, dims = 1:10)

#Plot tSNE
tSNE_plot <- DimPlot(your_seurat_object, reduction = "tsne") + ggtitle("tSNE")

ggsave_new(filename = "tSNE_plot", 
           results_path=dirname(plots_path), 
           plot=tSNE_plot)

