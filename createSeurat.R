

# Load the Seurat package
library(Seurat)

# Load the count data from the RDS file
memory.count.data <- readRDS("./test_data/Memory_Tcells_counts.rds")
# Load the metadata from the CSV file
memory.metadata <- read.csv("./test_data/Memory_Tcells_metadata.csv", row.names = 1)
# Create a Seurat object
memory.seurat.object <- CreateSeuratObject(counts = memory.count.data, project = "snakemake")
# Add the metadata to the Seurat object
memory.seurat.object<-AddMetaData(memory.seurat.object, memory.metadata)
# normalization:
memory.seurat.object <- NormalizeData(memory.seurat.object, normalization.method = "LogNormalize", scale.factor = 10000)
# scaling
memory.seurat.object <- ScaleData(memory.seurat.object, features = rownames(memory.seurat.object))
saveRDS(memory.seurat.object, file = "./test_data/Memory_Tcells_seurat.rds")

# Load the count data from the RDS file
naive.count.data <- readRDS("./test_data/Naive_Tcells_counts.rds")
# Load the metadata from the CSV file
naive.metadata <- read.csv("./test_data/Naive_Tcells_metadata.csv", row.names = 1)
# Create a Seurat object
naive.seurat.object <- CreateSeuratObject(counts = naive.count.data, project = "snakemake")
# Add the metadata to the Seurat object
naive.seurat.object<-AddMetaData(naive.seurat.object, naive.metadata)
# normalization:
naive.seurat.object <- NormalizeData(naive.seurat.object, normalization.method = "LogNormalize", scale.factor = 10000)
# scaling
naive.seurat.object <- ScaleData(naive.seurat.object, features = rownames(naive.seurat.object))
saveRDS(naive.seurat.object, file = "./test_data/Naive_Tcells_seurat.rds")




