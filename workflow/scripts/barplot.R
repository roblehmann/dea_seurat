# Load necessary libraries
#library(readr)
library(Seurat)
library(ggplot2)

#Input
seurat_object_path <- snakemake@input[["seurat_object"]]

# outputs
barplot_path <- snakemake@output[["barplot"]]

## parameters
assay <- snakemake@params[["assay"]] 
metadata <- snakemake@params[["metadata"]] 

# source utility functions
source("workflow/scripts/utils.R")
snakemake@source("./utils.R")

### plot specifications
widths <- 5
heights <- 5

obj <- readRDS(file = file.path(seurat_object_path))

meta <- obj@meta.data
condition_freq <- table(meta$cytokine.condition)
condition_df <- as.data.frame(condition_freq)
colnames(condition_df) <- c("Condition", "Frequency")

#plot
barplot<-ggplot(condition_df, aes(x=Condition, y=Frequency)) + 
	  geom_bar(stat="identity") + 
	    theme_minimal() + 
	      labs(title="Frequency of Conditions", x="Condition", y="Frequency")

#save
ggsave_new(filename = "barplot", 
                results_path=dirname(barplot_path), 
                plot=barplot,
           width=widths, 
           height=heights)	   
